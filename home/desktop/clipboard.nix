{ pkgs, lib, ... }:
{
  # Cliphist
  services.cliphist = {
    enable = true;
    systemdTarget = "hyprland-session.target";
  };

  # wl-clipboard
  home.packages = with pkgs.unstable; lib.mkAfter [ wl-clipboard ];
}
