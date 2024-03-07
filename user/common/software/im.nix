{ pkgs, lib, ... }:
{
  home.packages = with pkgs.unstable; lib.mkAfter [
    qq
    telegram-desktop
    element-desktop
  ];
}
