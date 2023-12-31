{ inputs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.chaotic.nixosModules.default
    inputs.impermanence.nixosModules.impermanence
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.nh.nixosModules.default

    # Nix配置
    ./global/nix.nix
    # 全局配置
    ./global/config.nix
    # Home-Manager
    ./global/homemanager.nix

    # 文件系统
    ./system/filesystem.nix
    # 持久化
    ./system/impermanence.nix
    # 引导
    ./system/boot.nix
    # 安全启动
    ./system/secureboot.nix
    # 内核
    ./system/kernel.nix
    # TPM2
    ./system/tpm.nix
    # 启动
    ./system/launcher.nix

    # 硬件
    ./hardware/hardware.nix
    # 显卡
    ./hardware/gpu.nix
    # 音频
    ./hardware/audio.nix
    # 网络
    ./hardware/network.nix
    # 蓝牙
    ./hardware/bluetooth.nix

    # 用户
    ./user/user.nix
    # 地区
    ./user/locale.nix
    # 安全
    ./user/secure.nix
    # Shell
    ./user/shell.nix
    # 性能
    ./user/power.nix

    # OpenSSH
    ./software/openssh.nix
    # CLI
    ./software/nh.nix
    # 代理
    ./software/proxy.nix
  ];
}
