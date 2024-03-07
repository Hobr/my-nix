{ config, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # Libinput
  services.xserver.libinput.enable = true;

  # Fwupd
  services.fwupd.enable = true;

  # 文件系统支持
  boot.supportedFilesystems = [ "btrfs" "ntfs" "vfat" "ext4" "fat" "tmpfs" ];
}
