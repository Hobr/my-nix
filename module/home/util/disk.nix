{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.util.disk;
in
{
  options.home.util.disk.enable = mkEnableOption "disk";

  config = mkIf cfg.enable {
    services.udiskie = {
      enable = true;
      automount = true;
      notify = true;
      tray = "never";
    };

    home.packages = with pkgs; [
      ddrescue
    ];
  };
}
