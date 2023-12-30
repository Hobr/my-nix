{ pkgs, ... }:
{
  boot = {
    # 版本
    kernelPackages = pkgs.linuxPackages_cachyos;

    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];

    consoleLogLevel = 0;
    kernelParams = [ "quiet" "udev.log_level=3" "nowatchdog" "systemd.gpt_auto=0" ];

    # 初始化阶段
    initrd = {
      availableKernelModules = [ "xhci_pci" "thunderbolt" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ "dm-snapshot" ];
    };
  };

  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-cpp-rules;
  };
}
