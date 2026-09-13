{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.sys.program.shell;
in
{
  options.sys.program.shell.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    programs.fish.enable = true;
    users.defaultUserShell = pkgs.fish;
  };
}
