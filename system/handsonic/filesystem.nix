{
  # LUKS
  boot.initrd.luks.devices.luksroot.device = "/dev/disk/by-uuid/9dda2070-f5bb-4518-8d38-fc8d71aa0e36";

  # 挂载
  fileSystems = {
    # 引导
    "/boot" = {
      device = "/dev/disk/by-uuid/532D-B974";
      fsType = "vfat";
      options = [ "umask=0077" ];
    };

    # 根目录
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [
        "defaults"
        "size=16G"
        "mode=755"
      ];
    };

    # 持久化
    "/persist" = {
      device = "/dev/mapper/system-root";
      fsType = "btrfs";
      neededForBoot = true;
      options = [
        "defaults"
        "ssd"
        "discard"
        "noatime"
        "space_cache=v2"
        "compress=zstd"
        "subvol=@persist"
      ];
    };

    # Nix
    "/nix" = {
      device = "/dev/mapper/system-root";
      fsType = "btrfs";
      options = [
        "defaults"
        "ssd"
        "discard"
        "noatime"
        "space_cache=v2"
        "compress=zstd"
        "subvol=@nix"
      ];
    };

    # 用户
    "/home" = {
      device = "/dev/mapper/system-root";
      fsType = "btrfs";
      options = [
        "defaults"
        "ssd"
        "discard"
        "noatime"
        "space_cache=v2"
        "compress=zstd"
        "subvol=@home"
      ];
    };

    # Windows 分区
    "/mnt/windows" = {
      device = "/dev/disk/by-uuid/48EE4C37EE4C2014";
      fsType = "ntfs3";
      options = [
        "nofail"
        "rw"
        "discard"
        "uid=1000"
      ];
    };

    "/mnt/data" = {
      device = "/dev/disk/by-uuid/5A9C7E8B6EE23C3F";
      fsType = "ntfs3";
      options = [
        "nofail"
        "rw"
        "discard"
        "uid=1000"
      ];
    };
  };

  # 交换
  swapDevices = [ { device = "/dev/mapper/system-swap"; } ];
}
