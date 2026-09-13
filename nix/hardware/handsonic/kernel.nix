{
  # Module
  boot = {
    kernelModules = [ "kvm-intel" ];
    blacklistedKernelModules = [ "asus_wmi" ];
    extraModulePackages = [ ];

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [ "dm-snapshot" ];
    };
  };
}
