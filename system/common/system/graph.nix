{ pkgs, lib, ... }:
{
  # Greetd
  programs.regreet = {
    enable = true;
    settings = { };
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
    xwayland.enable = true;
  };

  # XDG
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.unstable.xdg-desktop-portal-gtk ];
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
