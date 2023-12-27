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
    pinentryFlavor = "gnome3";
  };
}
