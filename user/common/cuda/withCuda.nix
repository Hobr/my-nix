{ pkgs, ... }: {
  # CUDA
  nixpkgs.config.cudaSupport = true;

  programs.btop.package = pkgs.btop.override { cudaSupport = true; };

  home.packages = with pkgs; [
    (openai-whisper-cpp.override { cudaSupport = true; })
    (blender.override { cudaSupport = true; })
  ];
}
