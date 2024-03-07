{ pkgs, lib, ... }:
{
  home.packages = with pkgs.unstable; lib.mkAfter [
    coreutils-full
    gnumake
    gnused
    gnugrep
    gnutar
  ];
}
