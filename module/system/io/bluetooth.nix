{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.sys.io.bluetooth;
in
{
  options.sys.io.bluetooth.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    services.blueman.enable = true;
  };
}
