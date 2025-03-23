{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.sys.program.teamviewer;
in
{
  options.sys.program.teamviewer.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    services.teamviewer.enable = true;
  };
}
q
