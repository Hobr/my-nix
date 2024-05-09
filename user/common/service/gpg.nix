{ pkgs, ... }:
{
  programs.gpg = {
    enable = true;
  };

  home.packages = with pkgs; [
    pinentry-gnome3
    sops
  ];
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
    pinentryFlavor = "gnome3";
    extraConfig = ''
      pinentry-program ${pkgs.pinentry-gnome3}/bin/pinentry
    '';
  };
}
