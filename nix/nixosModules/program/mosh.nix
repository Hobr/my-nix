{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.sys.program.mosh;
in
{
  options.sys.program.mosh.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    programs.mosh.enable = true;
    services.logind.settings.Login.KillUserProcesses = false;
    environment.systemPackages = [ pkgs.mosh ];
  };
}
