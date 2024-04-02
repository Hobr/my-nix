{pkgs, ...}: {
  programs.btop.package = pkgs.unstable.btop.override {cudaSupport = true;};

  home.packages = with pkgs.unstable; [
    (openai-whisper-cpp.override {
      cudaSupport = true;
    })
    (blender.override {
      cudaSupport = true;
    })
  ];
}
