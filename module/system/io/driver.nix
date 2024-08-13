{
  config,
  options,
  lib,
  modulesPath,
  ...
}:
with lib;
let
  cfg = config.system.driver;
in
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  options.system.driver.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    # Libinput
    services.libinput.enable = true;

    # Fwupd
    services.fwupd.enable = true;

    # 文件系统支持
    boot.supportedFilesystems = [
      "btrfs"
      "ntfs"
      "vfat"
      "ext4"
      "fat"
      "tmpfs"
    ];
  };
}
