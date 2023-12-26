{inputs,...}:
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];
  boot = {
    # 文件系统支持
    supportedFilesystems = ["btrfs" "ntfs" "vfat" ];

    # LUKS设备
    initrd.luks.devices.luksroot.device = "/dev/nvme0n1";
  };

  # 挂载
  fileSystems = {
    # 引导
    "/boot" = {
      device = "/dev/nvme1n1p1";
      fsType = "vfat";
      options = [ "rw" "noatime" "errors=remount-ro" ];
    };

    # 根分区
    "/" ={
      device = "/dev/mapper/system-root";
      fsType = "btrfs";
      options = [ "defaults" "ssd" "discard" "noatime" "space_cache=v2" "compress=zstd" "subvol=@" ];
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
      options = [ "defaults" "ssd" "discard" "noatime" "space_cache=v2" "compress=zstd" "subvol=@nix"];
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
  swapDevices = [ { device = "/dev/mapper/system-swap"; }];

  # 重置@卷
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/mapper/system-root /btrfs_tmp
    if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';
}
