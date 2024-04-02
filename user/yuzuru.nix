{outputs, ...}: {
  imports = [
    ./common
    ./config/yuzuru
    ./cuda/withoutCuda.nix
  ];

  home = {
    username = "yuzuru";
    homeDirectory = "/home/yuzuru";
    stateVersion = "23.11";
  };
}
