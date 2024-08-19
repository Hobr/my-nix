{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.sys.boot.systemd-boot;
in
{
  options.sys.boot.systemd-boot.enable = mkEnableOption "enable";

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
