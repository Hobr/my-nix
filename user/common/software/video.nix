{ pkgs, inputs, ... }: {
  programs.mpv.enable = true;

  home.packages = with pkgs; [
    ffmpeg
    yt-dlp
    inputs.hobr.packages.${pkgs.system}.aegisub
  ];
}
