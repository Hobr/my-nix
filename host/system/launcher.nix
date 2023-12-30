{ pkgs, ... }:
{
  # Greet
  environment.etc."greetd/environments".text = ''
    Hyprland
  '';

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "Hyprland";
        user = "kanade";
      };
      default_session = initial_session;
    };
  };

  # 自动登录
#  services.xserver.displayManager.autoLogin = {
#    enable = true;
#    user = "kanade";
#  };
#  systemd.services."getty@tty1".enable = false;
#  systemd.services."autovt@tty1".enable = false;

  # Hyprland
  programs.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    xwayland.enable = true;
  };

  # XDG Portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # seatd
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
