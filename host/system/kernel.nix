{ pkgs, inputs, lib, ... }:
{
  imports = [
    inputs.chaotic.nixosModules.default
  ];
  # CachyOS Kernel
  environment.systemPackages = lib.mkAfter [ pkgs.scx ];

  boot = {
    # 版本
    kernelPackages = pkgs.linuxPackages_cachyos-sched-ext;

    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];

    # 初始化阶段
    initrd = {
      availableKernelModules = [ "xhci_pci" "thunderbolt" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ "dm-snapshot" ];
    };
  };
}
