{ pkgs, ... }: {
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
}
