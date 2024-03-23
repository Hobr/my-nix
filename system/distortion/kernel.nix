{
  # Module
  boot = {
    kernelModules = ["kvm-intel"];
    kernelParams = [
      "i915.enable_psr=2"
      "i915.modeset=1"
    ];
    extraModulePackages = [];

    initrd = {
      availableKernelModules = ["xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
      kernelModules = ["dm-snapshot" "i915"];
    };
  };
}
