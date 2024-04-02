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
  ];
}
