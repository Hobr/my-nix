{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.system.bluetooth;
in
{
  options.system.bluetooth.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    services.blueman.enable = true;
  };
}
