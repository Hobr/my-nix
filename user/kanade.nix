{
  imports = [
    ./common
    ./config/kanade
  ];

  home = {
    username = "kanade";
    homeDirectory = "/home/kanade";
    stateVersion = "24.05";
  };

  nixpkgs.config.cudaSupport = true;
}
