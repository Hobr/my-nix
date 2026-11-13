{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.sys.boot.bootvine;
in
{
  options.sys.boot.bootvine.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    services.bootvine.enable = true;
  };
}
