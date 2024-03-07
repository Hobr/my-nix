{ pkgs, lib, ... }:
{
  # Cliphist
  services.cliphist = {
    enable = true;
    package = pkgs.unstable.cliphist;
    systemdTarget = "hyprland-session.target";
  };

  # wl-clipboard
  home.packages = lib.mkAfter [ pkgs.unstable.wl-clipboard ];
}
