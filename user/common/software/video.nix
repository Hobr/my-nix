{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    vlc
    ffmpeg_7
    yt-dlp
    # losslesscut-bin
    inputs.hobr.packages.${pkgs.system}.aegisub
  ];
}
