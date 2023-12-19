{
  fileSystems = {
    "/boot" = {
      device = "/dev/nvme1n1p1";
      fsType = "vfat";
    };

    "/" = {
      device = "/dev/mapper/system-root";
      fsType = "btrfs";
      options = [ "subvol=root" ];
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

  # Opt-in
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
