{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [
    nano
    wget
    fastfetch
    nixpkgs-fmt
    xorg.xlsclients
  ];
}
