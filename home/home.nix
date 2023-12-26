{
  home = {
    username = "kanade";
    homeDirectory = "/home/kanade";
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
}
