{ pkgs, lib, ... }:
{
  home.packages = with pkgs.unstable; lib.mkAfter [
    hyprpicker
    slurp
    swappy
    grimblast
  ];
}
