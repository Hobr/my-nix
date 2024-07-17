{ pkgs, ... }:
{
  programs.gpg = {
    enable = true;
  };

  home.packages = with pkgs; [ sops ];

  services.gnome-keyring = {
    enable = true;
    components = [
      "pkcs11"
      "secrets"
      "ssh"
    ];
  };

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}
