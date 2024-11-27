{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.sys.gpu.nvidia;
in
{
  options.sys.gpu.nvidia.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
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

    environment.systemPackages =
      with pkgs;
      [
        libva
        mesa

        # NVTop
        nvtopPackages.nvidia
      ]
      ++ (with vulkanPackages_latest; [
        vulkan-loader
        vulkan-validation-layers
        vulkan-extension-layer
        vulkan-tools
      ]);

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

    hardware.nvidia-container-toolkit = {
      enable = true;
      mount-nvidia-executables = true;
      mount-nvidia-docker-1-directories = true;
    };
  };
}
