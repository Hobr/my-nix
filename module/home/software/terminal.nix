{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.home.software.terminal;
in
{
  options.home.software.terminal.enable = mkEnableOption "terminal";

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      font = {
        name = "Mononoki Nerd Font";
        size = 12;
      };
    };
  };
}
