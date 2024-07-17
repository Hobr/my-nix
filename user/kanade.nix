{
  imports = [
    ./common
    ./config/kanade
    ./common/cuda/withCuda.nix
  ];

  home = {
    username = "kanade";
    homeDirectory = "/home/kanade";
    stateVersion = "24.05";
  };
}
