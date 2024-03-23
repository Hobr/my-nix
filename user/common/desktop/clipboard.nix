{pkgs, ...}: {
  # Cliphist
  services.cliphist = {
    enable = true;
    package = pkgs.unstable.cliphist;
    systemdTarget = "hyprland-session.target";
  };

  # wl-clipboard
  home.packages = [pkgs.unstable.wl-clipboard];
}
