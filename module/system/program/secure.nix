{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.sys.program.secure;
in
{
  options.sys.program.secure.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    # Rtkit
    security.rtkit.enable = true;

    # Polkit
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
      login = {
        enableGnomeKeyring = true;
        gnupg.enable = true;
      };
    };

    # Gnome Keyring
    services.gnome.glib-networking.enable = true;
    services.dbus.packages = [ pkgs.gcr_3 ];
    programs.seahorse.enable = true;

    # Logind
    services.logind = {
      enable = true;
      settings.Login = {
        HandleLidSwitch = "suspend";
        HandleLidSwitchExternalPower = "lock";
        HandlePowerKey = "suspend";
      };
    };
  };
}
