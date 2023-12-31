{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    bindings = { };
    defaultProfiles = [ ];
    config = { };
    scripts = with pkgs.mpvScripts; [ mpris ];
  };
}
