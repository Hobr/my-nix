{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.theme;
in
{
  options.home.theme.enable = mkEnableOption "theme";

  config = mkIf cfg.enable {
  };
}
