{
  boot = {
    # 文件系统支持
    supportedFilesystems = ["btrfs" "ntfs"];

    # LUKS设备
    initrd.luks.devices."luks-UUID";
  };

  # 挂载
  fileSystems = {
    "/boot" =
      { device = "/dev/xxx";
        fsType = "vfat";
      };

    "/" =
      { device = "/dev/xxx";
        fsType = "ext4";
      };

    "/mnt/windows" =
      { device = "/dev/nvme1n1p3";
        fsType = "ntfs-3g";
        options = [ "rw" ];
      };

    "/mnt/data" =
      { device = "/dev/nvme1n1p4";
        fsType = "ntfs-3g";
        options = [ "rw" ];
      };

  };

  # 交换
  swapDevices = [ { device = "/dev/xxx"; }];
}
