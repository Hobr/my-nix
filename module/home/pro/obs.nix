{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.pro.obs;
in
{
  options.home.pro.obs.enable = mkEnableOption "obs";

  config = mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
    };
  };
}