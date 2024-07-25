{
  config,
  pkgs,
  lib,
  ...
}:
{
  # OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
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
    nvtopPackages.nvidia
  ];

  # NVIDIA驱动
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    open = true;
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    nvidiaSettings = false;
    dynamicBoost.enable = true;
  };

  environment.sessionVariables.CUDA_PATH = pkgs.cudatoolkit;

  hardware.nvidia-container-toolkit = {
    enable = true;
    mount-nvidia-executables = true;
    mount-nvidia-docker-1-directories = true;
  };
}
