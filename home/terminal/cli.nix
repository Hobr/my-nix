{ pkgs, lib, ... }:
{
  home.packages = with pkgs.unstable; lib.mkAfter [
    nano
    nixpkgs-fmt

    wget
    httpie

    fastfetch
    xorg.xlsclients

    brightnessctl
    trash-cli

    sd
    ranger
    dialog

    p7zip
    zip
    unzip
  ];
}
