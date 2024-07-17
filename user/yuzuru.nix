{
  imports = [
    ./common
    ./config/yuzuru
    ./common/cuda/withoutCuda.nix
  ];

  home = {
    username = "yuzuru";
    homeDirectory = "/home/yuzuru";
    stateVersion = "24.05";
  };
}
