{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.home.software.sync;
in
{
  options.home.software.sync.enable = mkEnableOption "sync";

  config = mkIf cfg.enable {
    # Syncthing
    services.syncthing = {
      enable = true;
    };
  };
}
