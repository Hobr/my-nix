{outputs, ...}: {
  imports = [
    # Nix
    ./nix.nix

    # 文件系统
    ./filesystem.nix
    # 引导
    ./boot.nix

    # 用户
    ./user.nix

    # 硬件
    ./hardware.nix
    # NVIDIA
    ./nvidia.nix

    # 网络
    ./network.nix

  ];
}
