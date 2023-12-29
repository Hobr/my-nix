{ pkgs, inputs, lib, ... }:
{
  imports = [
    inputs.chaotic.nixosModules.default
  ];

  # sched_ext
  environment.systemPackages = lib.mkAfter [ pkgs.scx ];

  boot = {
    # 版本
    kernelPackages = pkgs.linuxPackages_cachyos-sched-ext;

    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];

    kernelParams = [ "quiet" "loglevel=0" "nowatchdog" ];

    # 初始化阶段
    initrd = {
      availableKernelModules = [ "xhci_pci" "thunderbolt" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "nvidia" "nvidia_drm" "nvidia_modeset" "nvidia_uvm" ];
      kernelModules = [ "dm-snapshot" ];
    };
  };

  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-cpp-rules;
  };
}
