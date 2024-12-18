{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.software.music;
in
{
  options.home.software.music.enable = mkEnableOption "music";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ qcm ];
  };
}
