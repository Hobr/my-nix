{ lib, pkgs, ... }:
{
  # Sudo
  security.sudo = {
    enable = true;
    # Wheel组无需密码
    wheelNeedsPassword = false;
  };
  users.users.kanade.extraGroups = lib.mkAfter [ "wheel" ];

  # Rtkit
  security.rtkit.enable = true;
  environment.systemPackages = [ pkgs.polkit_gnome ];
  security.polkit.enable = true;
  services.gnome.glib-networking.enable = true;
  programs.seahorse.enable = true;
  services.dbus.packages = [ pkgs.gcr ];
}
