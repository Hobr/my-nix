{ pkgs, lib, ... }:
{
  home.packages = with pkgs.unstable; lib.mkAfter [
    telegram-desktop
    qq
    fractal
  ];
}
