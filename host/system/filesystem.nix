{ pkgs, ... }:
{
  boot = {
    # 文件系统支持
    supportedFilesystems = [ "btrfs" "ntfs" "vfat" "ext4" "fat" "tmpfs" ];

    # LUKS
    initrd.luks.devices.luksroot.device = "/dev/nvme0n1";
  };
  # GVFS
  services.gvfs.enable = true;
  # 挂载
  services.udisks2.enable = true;

  # 挂载
  fileSystems = {
    # 引导
    "/boot" = {
      device = "/dev/nvme1n1p1";
      fsType = "vfat";
    };

    # 根目录
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=16G" "mode=755" ];
    };

    # 持久化
    "/persist" = {
      device = "/dev/mapper/system-root";
      fsType = "btrfs";
      neededForBoot = true;
      options = [ "defaults" "ssd" "discard" "noatime" "space_cache=v2" "compress=zstd" "subvol=@persist" ];
    };

    # Nix
    "/nix" = {
      device = "/dev/mapper/system-root";
      fsType = "btrfs";
      options = [ "defaults" "ssd" "discard" "noatime" "space_cache=v2" "compress=zstd" "subvol=@nix" ];
    };

    # 用户
    "/home" = {
      device = "/dev/mapper/system-root";
      fsType = "btrfs";
      options = [ "defaults" "ssd" "discard" "noatime" "space_cache=v2" "compress=zstd" "subvol=@home" ];
    };

    # Windows 分区
    "/mnt/windows" = {
      device = "/dev/nvme1n1p3";
      fsType = "ntfs-3g";
      options = [ "defaults" ];
    };

    "/mnt/data" = {
      device = "/dev/nvme1n1p4";
      fsType = "ntfs-3g";
      options = [ "defaults" ];
    };
  };

  # 交换
  swapDevices = [{ device = "/dev/mapper/system-swap"; }];

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

  # Snapper
  services.snapper = {
    snapshotInterval = "daily";
    cleanupInterval = "3d";
    configs = {
      nix = {
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        SUBVOLUME = "/nix";
        ALLOW_USERS = [ "kanade" ];
        ALLOW_GROUPS = [ "wheel" ];
      };
      persist = {
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        SUBVOLUME = "/persist";
        ALLOW_USERS = [ "kanade" ];
        ALLOW_GROUPS = [ "wheel" ];
      };
      home = {
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        SUBVOLUME = "/home";
        ALLOW_USERS = [ "kanade" ];
        ALLOW_GROUPS = [ "wheel" ];
      };
    };
  };
}
