{ pkgs, ... }:
{
  boot = {
    # 文件系统支持
    supportedFilesystems = [ "btrfs" "ntfs" "vfat" "ext4" "fat" "tmpfs" ];

    # LUKS设备
    initrd.luks.devices.luksroot.device = "/dev/nvme0n1";
  };
  # GVFS
  services.gvfs.enable = true;
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

    # 持久化分区
    "/persist" = {
      device = "/dev/mapper/system-root";
      fsType = "btrfs";
      neededForBoot = true;
      options = [ "defaults" "ssd" "discard" "noatime" "space_cache=v2" "compress=zstd" "subvol=@persist" ];
    };

    "/nix" = {
      device = "/dev/mapper/system-root";
      fsType = "btrfs";
      options = [ "defaults" "ssd" "discard" "noatime" "space_cache=v2" "compress=zstd" "subvol=@nix" ];
    };

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

  services.btrfs.autoScrub = {
    enable = true;
    fileSystems = [
      "/nix"
      "/home"
      "/persist"
    ];
    interval = "weekly";
  };

  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  environment.systemPackages = with pkgs; [
    btrfs-progs
    btrfs-assistant
    btrbk
  ];

  services.btrbk = {
    extraPackages = pkgs.zstd;
  };
}
