{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.sys.disk.persist;
in
{
  options.sys.disk.persist.enable = mkEnableOption "enable";

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
