{
  fileSystems = {
    "/boot" = {
      device = "/dev/nvme1n1p1";
      fsType = "vfat";
    };

    "/nix" = {
      device = "/dev/mapper/system-root";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

    "/persistent" = {
      device = "/dev/mapper/system-root";
      neededForBoot = true;
      fsType = "btrfs";
      options = [ "subvol=persistent" ];
    };

    "/mnt/windows" = {
      device = "/dev/nvme1n1p3";
      fsType = "ntfs-3g";
    };

    "/mnt/data" = {
      device = "/dev/nvme1n1p4";
      fsType = "ntfs-3g";
    };
  };

  # 文件系统支持
  boot.supportedFilesystems.supportedFilesystems = [ "btrfs" "ext4" "vfat" "fat" "ntfs" "exfat" ];
  services.gvfs.enable = true;

  # 交换
  swapDevices = [ ];

  # LUKS
  boot.initrd = {
    luks.devices."system-root" = {
      device = "/dev/nvme0n1";
      allowDiscards = true;
    };
  };
}
