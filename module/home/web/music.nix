{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.web.music;
in
{
  options.home.web.music.enable = mkEnableOption "music";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ qcm ];
  };
}
