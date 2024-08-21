{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.sys.program.nh;
in
{
  options.sys.program.nh.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 3d --keep 10";
    };
  };
}
