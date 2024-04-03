{pkgs, ...}: {
  home.packages = with pkgs.unstable; [
    vlc
    ffmpeg-full
    yt-dlp
    losslesscut-bin
    aegisub
  ];
}
