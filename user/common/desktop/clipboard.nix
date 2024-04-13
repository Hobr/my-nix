{ pkgs, ... }: {
  # Cliphist
  services.cliphist = {
    enable = true;
    systemdTarget = "hyprland-session.target";
  };

  # wl-clipboard
  home.packages = [ pkgs.wl-clipboard ];
}
