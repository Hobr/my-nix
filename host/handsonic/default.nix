# UmiPro3 系统入口
{
  imports = [
    # 共用
    ../common

    # 引导
    ./boot.nix
    # i18n
    ./i18n.nix
    # 网络
    ./network.nix
    # SSH
    ./ssh.nix
    # 用户
    ./user.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
}
