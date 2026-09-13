{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.home.web.sync;
in
{
  options.home.web.sync.enable = mkEnableOption "sync";

  config = mkIf cfg.enable {
    # Syncthing
    services.syncthing = {
      enable = true;
    };
  };
}
