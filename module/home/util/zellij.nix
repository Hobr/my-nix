{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.util.zellij;
in
{
  options.home.util.zellij.enable = mkEnableOption "zellij";

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      enableZshIntegration = true;
      exitShellOnExit = true;
    };
  };
}
