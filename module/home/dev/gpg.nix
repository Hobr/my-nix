{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.dev.gpg;
in
{
  options.home.dev.gpg.enable = mkEnableOption "gpg";

  config = mkIf cfg.enable {
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
      pinentry.package = pkgs.pinentry-gnome3;
    };
  };
}
