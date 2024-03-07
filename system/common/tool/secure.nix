{ lib, pkgs, ... }:
{
  # Rtkit
  security.rtkit.enable = true;

  # Polkit
  environment.systemPackages = lib.mkAfter [ pkgs.polkit_gnome ];
  security.polkit.enable = true;

  # Sudo
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  # PAM
  security.pam.services = {
    greetd = {
      enableGnomeKeyring = true;
      gnupg.enable = true;
    };
  };

  # Gnome Keyring
  services.gnome.glib-networking.enable = true;
  services.dbus.packages = [ pkgs.gcr ];
  programs.seahorse.enable = true;

}
