{ pkgs, lib, ... }:
{
  programs.mpv = {
    enable = true;
    bindings = { };
    defaultProfiles = [ ];
    config = { };
    scripts = with pkgs.mpvScripts; [ mpris ];
  };

  home.packages = with pkgs.unstable; lib.mkAfter [
    ffmpeg-full
  ];
}
