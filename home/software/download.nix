{ pkgs, lib, ... }:
{
  # Aria
  programs.aria2 = {
    enable = true;
  };

  home.packages = with pkgs.unstable; lib.mkAfter [
    transmission_4
    transmission_4-gtk
  ];
}
