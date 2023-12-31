{ pkgs, lib, ... }:
{
  programs.gpg = {
    enable = true;
  };

  home.packages = lib.mkAfter [ pkgs.pinentry-gnome ];
  services.gnome-keyring = {
    enable = true;
    components = [ "pkcs11" "secrets" "ssh" ];
  };

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    pinentryFlavor = "gnome3";
    extraConfig = ''
      pinentry-program ${pkgs.pinentry.gnome3}/bin/pinentry
    '';
  };
}
