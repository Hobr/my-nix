{
  # LUKS
  boot.initrd.luks.devices.luksroot.device = "/dev/nvme0n1p2";

  # 挂载
  fileSystems = {
    # 引导
    "/boot" = {
      device = "/dev/nvme0n1p1";
      fsType = "vfat";
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
  };

  # 交换
  swapDevices = [ { device = "/dev/mapper/system-swap"; } ];
}
