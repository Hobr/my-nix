{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.disk.persist;
in
{
  options.disk.persist.enable = mkEnableOption "enable";

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
