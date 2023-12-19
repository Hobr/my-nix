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
    # Modesetting
    modesetting.enable = true;

    # 电源管理
    powerManagement.enable = true;
    powerManagement.finegrained = false;

    # 开源驱动
    open = true;

    # nvidia-settings
    nvidiaSettings = false;

    # 驱动包
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  boot.kernelParams = lib.mkAfter [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
}
