{
  imports = [
    ./nixpkg.nix

    # 开发环境
    ./direnv.nix
  ];

  programs.home-manager.enable = true;
  programs.git.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}
