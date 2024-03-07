{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.unstable.rofi-wayland;
    plugins = with pkgs.unstable; [ rofi-top rofi-rbw rofi-calc rofi-emoji rofi-systemd rofi-bluetooth rofi-pulse-select ];
  };
}
