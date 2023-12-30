{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [
    nano
    wget
    fastfetch
    eza
    nixpkgs-fmt
    xorg.xlsclients
    pciutils
  ];
}
