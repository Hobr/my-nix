{outputs, ...}: {
  imports = [
    ./common
    ./config/kanade
    ./cuda/withCuda.nix
  ];

  home = {
    username = "kanade";
    homeDirectory = "/home/kanade";
    stateVersion = "23.11";
  };

  # CUDA
  nixpkgs.config.cudaSupport = true;
}
