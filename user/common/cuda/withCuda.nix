{
  pkgs,
  config,
  ...
}: {
  # CUDA
  nixpkgs.config.cudaSupport = true;

  programs.btop.package = pkgs.unstable.btop.override {cudaSupport = true;};

  home.sessionVariables = {
    LD_LIBRARY_PATH = config.home.sessionVariables + "${pkgs.unstable.linuxPackages.nvidia_x11}/lib:${pkgs.ncurses5}/lib";
    CUDA_PATH = pkgs.unstable.cudatoolkit;
    EXTRA_LDFLAGS = "-L/lib -L${pkgs.unstable.linuxPackages.nvidia_x11}/lib";
    EXTRA_CCFLAGS = "-I/usr/include";
  };

  home.packages = with pkgs.unstable; [
    cudatoolkit
    cudaPackages.cudnn
    (openai-whisper-cpp.override {cudaSupport = true;})
    (blender.override {cudaSupport = true;})
  ];
}
