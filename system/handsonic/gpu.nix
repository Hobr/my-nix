{ config, pkgs, lib, ... }: {
  # OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
      nvidia-vaapi-driver
    ];
  };

  environment.systemPackages = with pkgs; [
    # Vulkan
    vulkan-loader
    vulkan-validation-layers
    vulkan-extension-layer
    vulkan-tools
    libva
    mesa

    # CUDA
    cudatoolkit
    cudaPackages.cudnn

    # NVTop
    nvtop
  ];

  # NVIDIA驱动
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    open = false;
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    nvidiaSettings = false;
  };

  environment.sessionVariables.CUDA_PATH = pkgs.cudatoolkit;
}
