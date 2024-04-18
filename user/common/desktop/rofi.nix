{ pkgs, ... }: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    catppuccin.enable = true;
    plugins = with pkgs; [
      rofi-top
      rofi-rbw
      rofi-calc
      rofi-emoji
      rofi-systemd
      rofi-bluetooth
      rofi-pulse-select
    ];
  };
}
