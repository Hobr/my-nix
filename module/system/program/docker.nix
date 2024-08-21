{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.sys.program.docker;
in
{
  options.sys.program.docker.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      liveRestore = true;
      enableOnBoot = true;
      autoPrune.enable = true;
      storageDriver = "btrfs";
    };
  };
}
