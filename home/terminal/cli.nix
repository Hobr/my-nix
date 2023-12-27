{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [
    wget
    fastfetch
    eza
    nixpkgs-fmt
  ];
}
