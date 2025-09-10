{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.desktop.menu;
in
{
  options.home.desktop.menu.enable = mkEnableOption "menu";

  config = mkIf cfg.enable {
    # 粘贴板
    programs.rofi = {
      enable = true;

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
  };
}
