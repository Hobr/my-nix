{ pkgs, ... }:
{
  # 内核
  boot = {
    # 版本
    kernelPackages = pkgs.linuxPackages_cachyos-sched-ext;

    # 内核参数
    consoleLogLevel = 0;
    kernelParams = [ "quiet" "udev.log_level=3" "nowatchdog" "systemd.gpt_auto=0" ];
  };

  # Module
  boot = {
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];

    initrd = {
      availableKernelModules = [ "xhci_pci" "thunderbolt" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ "dm-snapshot" ];
    };
  };

  # Ananicy
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-cpp-rules;
  };
}
