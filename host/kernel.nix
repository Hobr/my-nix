{pkgs,...}:
{
  boot = {
    # 版本
    kernelPackages = pkgs.linuxPackages_latest;

    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];

    # 初始化阶段
    initrd = {
      availableKernelModules = [ "xhci_pci" "thunderbolt" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ "dm-snapshot" ];
    };
  };
}
