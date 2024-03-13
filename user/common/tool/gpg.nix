{ pkgs, lib, ... }:
{
  programs.gpg = {
    enable = true;
    package = pkgs.unstable.gnupg;
  };

  home.packages = with pkgs.unstable; lib.mkAfter [ pinentry-gnome3 ];
  services.gnome-keyring = {
    enable = true;
    components = [ "pkcs11" "secrets" "ssh" ];
  };

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    pinentryFlavor = "gnome3";
    extraConfig = ''
      pinentry-program ${pkgs.unstable.pinentry-gnome3}/bin/pinentry
    '';
  };
}
