{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.desktop.waybar;
in
{
  options.home.desktop.waybar.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;

      systemd = {
        enable = true;
        targets = [
          "hyprland-session.target"
        ];
      };

      settings.mainBar = {
        position = "top";
        layer = "top";
        height = 5;
        margin-top = 5;
        margin-bottom = 0;
        margin-left = 250;
        margin-right = 250;
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "tray"
          "cpu"
          "memory"
          "disk"
          "pulseaudio"
          "network"
        ];
        clock = {
          format = "{:%H:%M}";
          tooltip = "true";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
          format-alt = "{:%d/%m}";
        };
        "hyprland/workspaces" = {
          active-only = false;
          disable-scroll = true;
          format = "{icon}";
          on-click = "activate";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-dow = "hyprctl dispatch workspace e-1";
          format-icons = {
            "1" = "󰈹";
            "2" = "";
            "3" = "󰘙";
            "4" = "󰙯";
            "5" = "";
            "6" = "";
            urgent = "";
            default = "";
            sort-by-number = true;
          };
          persistent-workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
          };
        };
        memory = {
          format = "󰟜 {}%";
          format-alt = "󰟜 {used} GiB"; # 
          interval = 2;
        };
        cpu = {
          format = "  {usage}%";
          format-alt = "  {avg_frequency} GHz";
          interval = 2;
        };
        disk = {
          # path = "/";
          format = "󰋊 {percentage_used}%";
          interval = 60;
        };
        network = {
          format-wifi = "  {signalStrength}%";
          format-ethernet = "󰀂 ";
          tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
          format-linked = "{ifname} (No IP)";
          format-disconnected = "󰖪 ";
        };
        tray = {
          icon-size = 20;
          spacing = 8;
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰖁 ";
          format-icons = {
            default = [ " " ];
          };
          scroll-step = 3;
          on-click = "pamixer -t";
        };
      };
    };

    # 状态栏
    services.network-manager-applet.enable = true;
    services.blueman-applet.enable = true;
  };
}
