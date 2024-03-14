{ pkgs, lib, inputs, ... }:
{
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
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };

  # XDG
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment.systemPackages = lib.mkAfter [ pkgs.unstable.xdg-utils ];

  # Seatd
  systemd.services = {
    seatd = {
      enable = true;
      description = "Seat management daemon";
      script = "${pkgs.unstable.seatd}/bin/seatd -g wheel";
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        RestartSec = "1";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
