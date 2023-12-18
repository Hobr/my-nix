{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = lib.mkForce [ "btrfs" "vfat" "f2fs" "ntfs" "cifs" "ext4" "vfat" ];
  };

  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [ "size=8G" "mode=755" ];
    };

    "/boot" = {
      device = "/dev/nvme1n1p1";
      fsType = "vfat";
      options = [ "noatime" "discard" ];
    };

    "/persist" = {
      neededForBoot = true;
      device = "/dev/mapper/system-root";
      fsType = "btrfs";
      options = [ "noatime" "discard" "subvol=@persist" "compress=zstd" ];
    };

    "/nix" = {
      neededForBoot = true;
      device = "/dev/mapper/system-root";
      fsType = "btrfs";
      options = [ "noatime" "discard" "subvol=@nix" "compress=zstd" ];
    };

    "/mnt/windows" = {
      device = "/dev/nvme1n1p3";
      fsType = "ntfs-3g";
      options = [ "rw" ];
    };

    "/mnt/data" = {
      device = "/dev/nvme1n1p4";
      fsType = "ntfs-3g";
      options = [ "rw" ];
    };
  };

  swapDevices = [{ device = "/dev/mapper/system-swap"; }];
  boot.resumeDevice = "/dev/mapper/system-swap";

  boot.initrd.luks.devices.luksroot = {
    device = "/dev/mapper/system";
    preLVM = true;
    allowDiscards = true;
  };

  nixpkgs.hostPlatform = "x86_64-linux";
}
