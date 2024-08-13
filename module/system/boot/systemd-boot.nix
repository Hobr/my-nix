{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.boot.systemd-boot;
in
{
  options.boot.systemd-boot.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    boot.loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
  };
}
