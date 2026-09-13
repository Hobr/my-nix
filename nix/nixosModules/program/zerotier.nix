{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.sys.program.zerotier;
in
{
  options.sys.program.zerotier.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    services.zerotierone = {
      enable = true;
      joinNetworks = [
        "ec98eddfd4694f42"
      ];
    };
  };
}
