# 设备配置扩展指南

本配置系统采用了基于设备类型的配置文件结构，可以轻松扩展到新设备。

## 配置文件结构

```
profiles/           # 设备类型配置文件
├── base.nix        # 基础配置 (所有设备共用)
├── gaming-laptop.nix   # 游戏本配置
├── portable-laptop.nix # 便携本配置 
├── server.nix      # 服务器配置
└── nas.nix         # NAS配置

user/profiles/      # 用户角色配置文件
├── base.nix        # 基础用户配置
├── desktop-full.nix    # 完整桌面用户配置
├── desktop-lite.nix    # 轻量桌面用户配置
└── server.nix      # 服务器用户配置

templates/          # 新设备模板文件
├── gaming-laptop-system.nix
├── portable-laptop-system.nix
├── server-system.nix
├── nas-system.nix
├── desktop-full-user.nix
├── desktop-lite-user.nix
└── server-user.nix
```

## 设备类型说明

### 游戏本 (Gaming Laptop)
- **特点**: 高性能，完整桌面环境，支持游戏和专业软件
- **包含**: 桌面环境、音频、蓝牙、虚拟化、Docker、代理等
- **适用于**: 高端笔记本、工作站笔记本

### 便携本 (Portable Laptop)  
- **特点**: 轻量级，基础桌面环境，节省资源
- **包含**: 桌面环境、音频、蓝牙，但不包含虚拟化和Docker
- **适用于**: 轻薄本、低功耗设备

### 服务器 (Server)
- **特点**: 无桌面环境，仅命令行界面
- **包含**: 基础系统、网络、虚拟化、Docker
- **适用于**: 专用服务器、云服务器

### NAS (Network Attached Storage)
- **特点**: 基于服务器配置，针对存储优化
- **包含**: 服务器配置 + 存储特定优化
- **适用于**: 网络存储设备、文件服务器

## 添加新设备

### 1. 选择设备类型

根据设备用途选择对应的模板:
- 游戏/高性能笔记本 → `gaming-laptop`
- 便携/轻薄笔记本 → `portable-laptop`  
- 服务器 → `server`
- NAS → `nas`

### 2. 创建系统配置

```bash
# 复制对应模板
cp templates/<DEVICE_TYPE>-system.nix system/<HOSTNAME>.nix

# 编辑配置文件
vim system/<HOSTNAME>.nix
```

需要修改的内容:
- `<HOSTNAME>` → 实际主机名
- `<USERNAME>` → 实际用户名  
- `<HASHED_PASSWORD>` → 实际密码哈希

### 3. 创建硬件配置

```bash
# 创建硬件配置目录
mkdir system/<HOSTNAME>

# 创建硬件配置文件 (通常从 nixos-generate-config 生成)
vim system/<HOSTNAME>/hardware.nix
vim system/<HOSTNAME>/kernel.nix  
vim system/<HOSTNAME>/filesystem.nix
```

### 4. 创建用户配置

```bash
# 复制对应用户模板
cp templates/<USER_TYPE>-user.nix user/<USERNAME>.nix

# 编辑用户配置
vim user/<USERNAME>.nix
```

需要修改的内容:
- `<USERNAME>` → 实际用户名
- 显示器配置 (如果是桌面用户)
- 壁纸配置 (可选)
- NVIDIA 配置 (如果需要)

### 5. 更新 flake.nix

在 `flake.nix` 中添加新的配置:

```nix
nixosConfigurations = {
  # 现有配置...
  
  # 新设备
  <HOSTNAME> = nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs outputs;
    };
    modules = [ ./system/<HOSTNAME>.nix ];
  };
};

homeConfigurations = {
  # 现有配置...
  
  # 新用户
  "<USERNAME>@<HOSTNAME>" = home-manager.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    extraSpecialArgs = {
      inherit inputs outputs;
    };
    modules = [ ./user/<USERNAME>.nix ];
  };
};
```

## 自定义配置

### 系统级自定义

在设备特定的配置文件中，可以覆盖 profile 中的任何设置:

```nix
sys = {
  # 覆盖 profile 中的配置
  program = {
    virtual.enable = false;  # 禁用虚拟化
    docker.enable = true;    # 启用 Docker
  };
  
  # 添加设备特定配置
  gpu.amd.enable = true;     # 启用 AMD GPU
};
```

### 用户级自定义

在用户特定的配置文件中，可以覆盖用户 profile 中的任何设置:

```nix
home = {
  # 覆盖 profile 中的配置
  pro = {
    video.enable = false;    # 禁用视频编辑软件
    obs.enable = true;       # 启用录屏软件
  };
  
  # 添加用户特定配置
  desktop.hypr.monitor = [
    "DP-1,3840x2160@60,0x0,1"
  ];
};
```

## 维护建议

1. **保持 profiles 最小化**: profile 中只包含该类型设备的通用配置
2. **设备特定配置放在设备文件中**: 硬件相关、显示器配置等放在具体设备配置中
3. **定期审查和更新**: 定期检查 profiles 中的配置是否合理
4. **文档同步更新**: 添加新配置时及时更新此文档

## 示例

参考现有设备配置:
- `system/handsonic.nix` - 游戏本示例
- `system/distortion.nix` - 便携本示例  
- `system/overdrive.nix` - NAS示例
- `user/kanade.nix` - 完整桌面用户示例
- `user/yuzuru.nix` - 轻量桌面用户示例
- `user/yuri.nix` - 服务器用户示例