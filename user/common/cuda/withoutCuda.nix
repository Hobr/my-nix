{pkgs, ...}: {
  programs.btop.package = pkgs.unstable.btop;
  
  home.packages = with pkgs.unstable; [
    openai-whisper-cpp.override
    blender
  ];
}
