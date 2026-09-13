# GM5TG0Y Windows 协议调查

本文用于在 MECHREVO Umi Pro 3 Series GM5TG0Y 上从 Windows 侧确认性能模式的实现方式，目的是为 Linux `tuxedo-drivers` 增加可靠的性能模式支持。

当前 Linux 状态：

- DMI board name：`GM5TG0Y`
- DMI product SKU：`0001`
- Uniwill model ID：`16`
- `tuxedo_compatibility_check` 已通过
- 风扇、键盘和 `uniwill_wmi` 已正常工作
- ODM performance profiles 仍为 `[]`

白名单只允许驱动加载，不会自动实现性能模式。需要确认 Windows 控制中心使用的是 ACPI-WMI、厂商驱动 IOCTL，还是直接 EC 协议。

## 1. 确认 Windows 功能

在 Windows 中安装并打开 MECHREVO 官方控制中心，记录：

- 可用模式名称，例如 Office、Balance、Turbo、Performance
- 是否存在 Fn 快捷键
- 切换模式时风扇、CPU 功耗、LED 是否变化
- 控制中心是否显示当前模式

这一步只确认功能存在，不足以确定协议。

## 2. 枚举 WMI 类

以管理员身份打开 PowerShell，执行：

```powershell
Get-CimInstance Win32_ComputerSystem |
  Format-List Manufacturer,Model

Get-CimInstance Win32_BaseBoard |
  Format-List Manufacturer,Product,Version

Get-CimClass -Namespace root/wmi |
  Where-Object {
    $_.CimClassName -match 'MECH|TONG|MIF|PERF|THERM|POWER|FAN|MODE'
  } |
  Select-Object CimClassName
```

```
Manufacturer : MECHREVO
Model        : Umi Pro 3 Series GM5TG0Y





Manufacturer : MECHREVO
Product      : GM5TG0Y
Version      : Standard




CimClassName
------------
KernelPerfStateDomainChange
MSNdis_StatusDevicePowerOn
MSNdis_StatusDevicePowerOff
ProcessorPerfStateEvent
KernelThermalPolicyChange
MSNdis_StatusDevicePowerOnEx
KernelPerfStateChange
PortCls_PowerState
PortCls_PowerPolicy
KernelThermalConstraintChange
MSNdis_StatusDevicePowerOffEx
POWER_CHANGE_EVENT
MobTabPerfTraceProvider
PerfInfo_V0
PerfInfo_V2
PerfInfo
SystemConfig_V1_Power
PerfInfo_V1
SystemConfig_V0_Power
SystemConfig_V2_Power
PowerEvents
RSSPlatformPerformanceTraceProvider
RSSPlatformBackgroundsyncPerformanceTraceProvider
MSDiskDriver_Performance
MSDiskDriver_PerformanceData
KernelPerfStates
POWER_DATA
KernelPerfState
PerformanceState
MSPower
MSPower_DeviceWakeEnable
MSPower_DeviceEnable
MSRedbook_Performance
MSSerial_PerformanceInformation
WmiFWVersion
MSNdis_80211_InfrastructureMode
MSNdis_80211_TransmitPowerLevel
MSNdis_SetInterruptModeration
MSNdis_80211_NumberOfAntennas
MSNdis_80211_AuthenticationMode
MSNdis_InterruptModerationParameters
MSNdis_QueryInterruptModeration
MSNdis_80211_PowerMode
VideoModeDescriptor
Win32_Perf
Win32_PerfRawData
MSiSCSI_NICPerformance
ProcessorPerformance
Win32_PerfFormattedData
WmiMonitorListedSupportedSourceModes
PerformanceStates
MSAcpi_ThermalZoneTemperature
```


也可以使用图形工具 **WMI Explorer** 检查：

- `root\wmi`
- `root\cimv2`

找到可疑类后查看方法签名：

```powershell
Get-CimClass -Namespace root/wmi -ClassName '类名' |
  Select-Object -ExpandProperty CimClassMethods
```

记录以下信息：

- WMI namespace
- class name
- method name
- 输入参数
- 输出参数
- event 或 notification

初次调查只枚举类和方法，不要在 WMI Explorer 中调用未知方法。

## 3. 导出 ACPI 表

准备 ACPICA 工具中的 `acpidump.exe` 和 `iasl.exe`，然后以管理员身份执行：

```powershell
mkdir C:\acpi-dump
Set-Location C:\acpi-dump

acpidump.exe -b

Get-ChildItem *.dat | ForEach-Object {
  iasl.exe -d $_.FullName
}

Select-String -Path *.dsl -Pattern `
  '_WDG','_WED','MIFS','MECH','TONG','GM5TG0Y','WMI'
```

重点查找：

- `_WDG`：ACPI-WMI GUID 描述
- `_WED`：WMI 事件数据
- `MIFS` 或 Tongfang 相关 GUID
- 性能、风扇、热管理相关方法

`_WDG` 中的 GUID 可以和 WMI Explorer 中发现的类或 GUID 对照。

## 4. 观察官方控制中心的调用

如果 WMI 枚举没有发现可用方法，使用 **API Monitor** 追踪官方控制中心进程。进程名可以在任务管理器中确认，可能类似：

```text
MechrevoControlCenter.exe
ControlCenter.exe
```

监控这些调用：

```text
IWbemServices::ExecMethod
IWbemServices::ExecMethodAsync
DeviceIoControl
```

执行一次最小化测试：

1. 启动 API Monitor 并附加到控制中心进程。
2. 记录当前模式。
3. 点击一次 Balance。
4. 点击一次 Turbo 或 Performance。
5. 保存调用日志。

需要记录每种模式对应的：

- WMI 类和方法，或 IOCTL 编号
- 输入 buffer
- 输出 buffer
- 返回值
- 调用前后的事件通知

如果看到的是 `DeviceIoControl`，说明协议由厂商 `.sys` 驱动封装；如果看到的是 WMI 方法，则可以按 WMI 协议实现 Linux 驱动。

## 5. 只读观察 EC 变化

如果确认官方控制中心最终操作 EC，可以使用 RWEverything 或类似工具进行只读对比：

1. Office 模式下记录 EC 状态。
2. 切换到 Balance，再记录。
3. 切换到 Turbo，再记录。
4. 比较变化的地址和值。

只允许读取，禁止使用以下功能：

```text
Write EC
Write I/O
Write Embedded Controller
Write CMOS
```

不要因为某个地址在模式切换时变化，就直接把该地址写进 Linux 驱动。还需要确认：

- 写入顺序
- 是否需要解锁
- 是否需要提交或确认命令
- 是否需要延迟
- 睡眠、恢复和关机时是否需要复原

## 6. 与当前 Linux 驱动对照

当前 `tuxedo-drivers` 已包含一套通用 Uniwill profile v1 实现，主要使用：

```text
0x0740  model ID
0x0741  profile/custom mode enable
0x0751  performance profile
```

已知 profile 值通常为：

```text
1 = powersave
2 = enthusiast
3 = overboost
```

如果 Windows 调用和这些 EC 地址、数值行为一致，Linux 侧可能只需要：

1. 在 `uniwill_keyboard.h` 的 `uniwill_profile_v1_three_profs` 列表中加入 `GM5TG0Y`。
2. 如需 TDP，在 `tuxedo_io.c` 的 `uw_id_tdp()` 中增加正确的 TDP 最小值和最大值。
3. 重新编译内核模块。
4. 确认 `tailor_hwcaps` 能报告 profile。

不能直接盲目复用其他 `GMxTGxx` 机型的 TDP 范围。不同 CPU、显卡和 BIOS 版本的安全范围可能不同。

如果 Windows 使用的是另一套 Tongfang/MECHREVO WMI 方法，就需要新增独立的平台驱动或 MIFS WMI 支持，不能只增加 DMI 名称。

## 7. 回到 NixOS 后需要保存的材料

最有价值的材料是以下三类：

- ACPI 反编译后包含 `_WDG` 的片段
- WMI Explorer 中可疑类的方法列表
- API Monitor 中切换一次模式的 `ExecMethod` 或 `DeviceIoControl` 记录

建议同时记录：

```text
Windows 版本
BIOS 版本
控制中心版本
可用模式名称
每次切换的时间顺序
```

这些信息足以判断是复用现有 Uniwill profile v1，还是需要实现新的 MECHREVO/Tongfang 协议。
