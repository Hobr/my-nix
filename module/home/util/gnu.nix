{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.util.gnu;
in
{
  options.home.util.gnu.enable = mkEnableOption "gnu";

  config = mkIf cfg.enable {
    home.packages = with pkgs.small; [
      coreutils-full
      gnumake
      gnused
      gnugrep
      gnutar
    ];
  };
}
