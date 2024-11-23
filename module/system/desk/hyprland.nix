{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.sys.desk.hyprland;
in
{
  options.sys.desk.hyprland.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    # Greet
    environment.etc."greetd/environments".text = ''
      Hyprland
    '';

    services.greetd = {
      enable = true;
      settings = rec {
        initial_session.command = "Hyprland";
        default_session = initial_session;
      };
    };

    # Hyprland
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };

    # XDG
    xdg.portal.enable = true;

    environment.systemPackages = [ pkgs.xdg-utils ];

    # Seatd
    systemd.services = {
      seatd = {
        enable = true;
        description = "Seat management daemon";
        script = "${pkgs.seatd}/bin/seatd -g wheel";
        serviceConfig = {
          Type = "simple";
          Restart = "always";
          RestartSec = "1";
        };
        wantedBy = [ "multi-user.target" ];
      };
    };
  };
}
