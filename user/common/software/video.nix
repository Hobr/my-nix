{ pkgs, inputs, ... }: {
  programs.mpv.enable = true;

  home.packages = with pkgs; [
    ffmpeg_7
    yt-dlp
    # losslesscut-bin
    inputs.hobr.packages.${pkgs.system}.aegisub
  ];
}
