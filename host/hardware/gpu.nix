{ config, lib, ... }:
{
  # OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    open = false;
    modesetting.enable = true;

    nvidiaSettings = false;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
  };

  boot.initrd.availableKernelModules = lib.mkAfter [ "nvidia" "nvidia_drm" "nvidia_modeset" "nvidia_uvm" ];
}
