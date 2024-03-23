{ pkgs,  inputs, ... }:
{
  home.packages = with pkgs.unstable; [
    hyprpicker
    slurp
    swappy
    grim
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
  ];
}
