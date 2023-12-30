{ pkgs, lib, ... }:
{
  programs.gpg = {
    enable = true;
  };

  home.packages = lib.mkAfter [ pkgs.unstable.pinentry-gnome ];
  services.gnome-keyring.enable = true;

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    enableSshSupport = true;
    pinentryFlavor = "gnome3";
    extraConfig = ''
      pinentry-program ${pkgs.pinentry.gnome3}/bin/pinentry
    '';
  };
}
