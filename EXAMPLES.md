# 配置系统使用示例

## 快速开始

### 1. 添加游戏本设备 (例子)

```bash
# 使用脚本快速创建配置
./add-device.sh gaming-laptop mygaming myuser

# 或者手动创建
cp templates/gaming-laptop-system.nix system/mygaming.nix
cp templates/desktop-full-user.nix user/myuser.nix

# 编辑配置文件
vim system/mygaming.nix  # 修改主机名、用户名、密码等
vim user/myuser.nix      # 修改用户名、显示器配置等
```

### 2. 添加服务器设备 (例子)

```bash
# 创建服务器配置
./add-device.sh server myserver serveruser

# 服务器配置会自动：
# - 禁用桌面环境
# - 禁用音频和蓝牙
# - 启用Docker和虚拟化
# - 使用命令行编辑器
```

### 3. 添加便携本设备 (例子)

```bash
# 创建便携本配置  
./add-device.sh portable-laptop mylaptop laptopuser

# 便携本配置会自动：
# - 启用轻量桌面环境
# - 禁用虚拟化和Docker (节省资源)
# - 减少大型软件安装
# - 优化功耗
```

## 配置对比

### 游戏本 vs 便携本

| 功能 | 游戏本 | 便携本 |
|------|--------|--------|
| 桌面环境 | ✅ 完整 | ✅ 轻量 |
| 虚拟化 | ✅ | ❌ |
| Docker | ✅ | ❌ |
| 专业视频软件 | ✅ | ❌ |
| OBS录屏 | ✅ | ❌ |
| Electron应用 | ✅ | ❌ |

### 桌面 vs 服务器

| 功能 | 桌面用户 | 服务器用户 |
|------|----------|------------|
| 桌面环境 | ✅ | ❌ |
| 图形浏览器 | ✅ | ❌ |
| 媒体软件 | ✅ | ❌ |
| VS Code | ✅ | ❌ |
| Neovim | ✅ | ✅ |

## 自定义示例

### 覆盖默认配置

```nix
# system/mydevice.nix
{
  imports = [ ../profiles/gaming-laptop.nix ];
  
  # 游戏本但不需要虚拟化
  sys.program.virtual.enable = false;
  
  # 自定义GPU配置
  sys.gpu.amd.enable = true;
}
```

```nix  
# user/myuser.nix
{
  imports = [ ./profiles/desktop-lite.nix ];
  
  # 便携本但需要视频编辑
  home.pro.video.enable = true;
  
  # 自定义显示器配置
  home.desktop.hypr.monitor = [
    "eDP-1,1920x1080@60,auto,1"
  ];
}
```

## 扩展到新设备类型

如果需要创建新的设备类型（比如平板电脑），可以：

1. 创建新的profile: `profiles/tablet.nix`
2. 继承合适的基础profile: `imports = [ ./portable-laptop.nix ];`
3. 添加平板特定配置: 触摸屏、旋转屏幕等
4. 创建对应的模板和用户profile
5. 更新文档

这样就能轻松支持新的设备类型了！