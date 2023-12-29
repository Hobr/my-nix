{ pkgs, inputs, lib, ... }:
{
  imports = [
    inputs.chaotic.nixosModules.default
  ];


  boot = {
    # 版本
    kernelPackages = pkgs.linuxPackages_cachyos-sched-ext;

    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];

    kernelParams = [ "quiet" "loglevel=0" "nowatchdog" ];

    # 初始化阶段
    initrd = {
      availableKernelModules = [ "xhci_pci" "thunderbolt" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ "dm-snapshot" ];
    };
  };

  # sched_ext
  environment.systemPackages = lib.mkAfter [ pkgs.scx ];
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-cpp-rules;
  };
}
