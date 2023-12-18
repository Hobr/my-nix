{
  imports = [
    # Nix
    ./nix.nix

    # 分区
    ./disko.nix
    # 文件系统
    ./filesystem.nix

    # 引导
    ./boot.nix

    # 基础硬件
    ./hardware.nix
    # 显卡
    ./nvidia.nix

    # 网络
    ./network.nix
    # 音频
    ./audio.nix

    # 用户
    ./user.nix
    ./i18n.nix

    # TODO 安全启动 & 无状态
    # ./secure.nix
    # ./impermanence.nix
  ];
}
