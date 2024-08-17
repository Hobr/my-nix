{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.boot.persist;
in
{
  options.boot.persist.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {

    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib"

        "/etc"
        "/root"
      ];
    };
  };
}
