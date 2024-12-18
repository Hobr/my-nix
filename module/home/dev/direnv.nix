{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.home.dev.direnv;
in
{
  options.home.dev.direnv.enable = mkEnableOption "direnv";

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
