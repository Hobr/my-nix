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
    environment.systemPackages = [ pkgs.polkit_gnome ];
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
      swaylock = { };
    };

    # Gnome Keyring
    services.gnome.glib-networking.enable = true;
    services.dbus.packages = [ pkgs.gcr ];
    programs.seahorse.enable = true;

    # Logind
    services.logind = {
      lidSwitch = "suspend";
      lidSwitchExternalPower = "lock";
      extraConfig = ''
        HandlePowerKey=suspend
      '';
    };
  };
}
