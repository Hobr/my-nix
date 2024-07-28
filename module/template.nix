{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.xxx;
in
{
  options.xxx.enable = mkEnableOption "enable";

  config = mkIf cfg.enable { };
}
