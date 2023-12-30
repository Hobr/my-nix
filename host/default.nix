{ inputs, ... }: {
  imports = [
    # Chaotic 软件包替换
    inputs.chaotic.nixosModules.default

    # Nix配置
    ./global/nix.nix
    # 全局配置
    ./global/config.nix
    # Home-Manager
    ./global/homemanager.nix

    # 文件系统
    ./system/filesystem.nix
    # 引导
    ./system/boot.nix
    # 内核
    ./system/kernel.nix
    # 持久化
    ./system/impermanence.nix
    # 安全启动
    ./system/secureboot.nix
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
    # Bluetooth
    ./hardware/bluetooth.nix
    # 网络
    ./hardware/network.nix

    # 用户
    ./user/user.nix
    # 地区
    ./user/locale.nix
    # Shell
    ./user/shell.nix
    # 安全
    ./user/secure.nix
    # 性能
    ./user/power.nix

    # CLI
    ./software/nh.nix
    # OpenSSH
    ./software/openssh.nix
    # 代理
    ./software/proxy.nix
  ];
}
