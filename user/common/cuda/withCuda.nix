{ pkgs, ... }:
{
  # CUDA
  nixpkgs.config.cudaSupport = true;

  programs.btop.package = pkgs.btop.override { cudaSupport = true; };

  home.packages = with pkgs; [
    whisper-ctranslate2
    (blender.override { cudaSupport = true; })
    ollama-cuda
  ];
}
