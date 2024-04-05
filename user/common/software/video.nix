{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs.unstable; [
    vlc
    ffmpeg-full
    yt-dlp
    losslesscut-bin
    avisynthplus
    inputs.hobr.packages.${pkgs.system}.aegisub
  ];
}
