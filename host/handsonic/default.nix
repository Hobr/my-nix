{
  imports = [
    # 共用
    ../common

    # 文件系统
    ./filesystem.nix
    # 引导
    ./boot.nix
    # 内核
    ./kernel.nix

    # 硬件
    ./hardware.nix
    # 显卡
    ./nvidia.nix
    # 声卡
    ./audio.nix
    # 网卡
    ./network.nix
    # 触控板
    ./touchpad.nix
    # 蓝牙
    ./bluetooth.nix

    # 用户
    ./user.nix
    # i18n
    ./i18n.nix

    # 安全
    ./secure.nix
    # SSH
    ./ssh.nix
    # GnuPG
    ./gnupg.nix
    # MPD
    ./mpd.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
}
