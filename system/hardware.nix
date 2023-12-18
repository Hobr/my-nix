{ pkgs, lib, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = lib.mkForce [ "btrfs" "vfat" "f2fs" "ntfs" "cifs" "ext4" "vfat" ];
  };

  nixpkgs.hostPlatform = "x86_64-linux";
}
