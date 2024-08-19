{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.sys.system.bluetooth;
in
{
  options.sys.system.bluetooth.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    services.blueman.enable = true;
  };
}
