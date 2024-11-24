{
  config,
  options,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  cfg = config.sys.desk.hyprland;
in
{
  options.sys.desk.hyprland.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    # Hyprland
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };

    environment.loginShellInit = ''
      if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ] && uwsm check may-start; then
          exec uwsm start hyprland-uwsm.desktop
      fi
    '';

    # XDG
    xdg.portal.enable = true;
    environment.systemPackages = [ pkgs.xdg-utils ];

    # Seatd
    services.seatd = {
      enable = true;
      group = "wheel";
      user = "root";
    };
  };
}
