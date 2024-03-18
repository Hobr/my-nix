{ pkgs, lib, inputs, ... }:
{
  home.packages = with pkgs.unstable; lib.mkAfter [
    hyprpicker
    slurp
    swappy
    grim
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
  ];
}
