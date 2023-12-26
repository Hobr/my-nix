{outputs, ...}: {
  imports = [
    # Nix配置
    ./nix.nix
    # 全局配置
    ./config.nix

    # 文件系统
    ./filesystem.nix
    # 引导
    ./boot.nix
    # 内核
    ./kernel.nix
    # 持久化
    ./impermanence.nix

    # 用户
    ./user.nix
    # 地区
    ./locale.nix
    # 安全
    ./secure.nix

    # 硬件
    ./hardware.nix
    # 显卡
    ./nvidia.nix
    # 音频
    ./audio.nix
    # 网络
    ./network.nix

    # 桌面
    ./desktop.nix
    # SSH
    ./ssh.nix
  ];
}
