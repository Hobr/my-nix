{ config, ... }:

{
  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "thunderbolt" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ "dm-snapshot" ];
    };

    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];

    supportedFilesystems = [ "btrfs" "vfat" "ntfs" "exfat" ];
  };

  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
}
