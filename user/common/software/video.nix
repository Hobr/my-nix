{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    bindings = {};
    defaultProfiles = [];
    config = {};
    scripts = with pkgs.mpvScripts; [mpris];
  };

  home.packages = with pkgs.unstable; [
    ffmpeg-full
    yt-dlp
    losslesscut-bin
    aegisub
    blender
    openai-whisper-cpp
    # cuda user
    #(openai-whisper-cpp.override {
    #  cudaSupport = true;
    #})
    #(blender.override {
    #  cudaSupport = true;
    #})
  ];
}
