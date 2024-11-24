{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.sys.disk.device;
in
{
  options.sys.disk.device.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    # SSD Trim
    services.fstrim = {
      enable = true;
      interval = "weekly";
    };

    # Btrfs Scrub
    services.btrfs.autoScrub = {
      enable = true;
      fileSystems = [
        "/nix"
        "/home"
        "/persist"
      ];
      interval = "weekly";
    };

    # GVFS
    services.gvfs.enable = true;
    services.tumbler.enable = true;

    # 挂载
    services.udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
  };
}
