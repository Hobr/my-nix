{ outputs, ... }: {
  imports = [
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
    # TPM2
    ./hardware/tpm.nix

    # 用户
    ./user/user.nix
    # 地区
    ./user/locale.nix
    # 安全
    ./user/secure.nix
    # Shell
    ./user/shell.nix

    # CLI
    ./software/nh.nix
    # 桌面
    ./software/desktop.nix
    # OpenSSH
    ./software/openssh.nix
    # 代理
    ./software/proxy.nix
  ];
}
