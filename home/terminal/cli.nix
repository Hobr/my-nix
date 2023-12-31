{ pkgs, lib, ... }:
{
  home.packages = with pkgs.unstable; lib.mkAfter [
    nano
    wget
    fastfetch
    nixpkgs-fmt
    xorg.xlsclients
    brightnessctl
    trash-cli
    sd
    ranger
  ];
}
