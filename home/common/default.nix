# 共通 用户入口
{
  imports = [
    ./nixpkg.nix
  ];

  programs.home-manager.enable = true;
  programs.git.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}
