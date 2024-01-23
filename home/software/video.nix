{ pkgs, lib, ... }:
{
  programs.mpv = {
    enable = true;
    package = pkgs.unstable.mpv;
    bindings = { };
    defaultProfiles = [ ];
    config = { };
    scripts = with pkgs.mpvScripts; [ mpris ];
  };

  home.packages = with pkgs.unstable; lib.mkAfter [
    ffmpeg-full
  ];
}
