{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.sys.desk.cosmic;
in
{
  options.sys.desk.cosmic.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    # Cosmic
    services = {
      desktopManager.cosmic.enable = true;
      displayManager.cosmic-greeter.enable = true;
    };

    # XDG
    xdg.portal.enable = true;
    environment.systemPackages = [ pkgs.xdg-utils ];
  };
}
