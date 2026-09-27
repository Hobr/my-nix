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
      extraPackages = with pkgs; [
        libva-vdpau-driver
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

        # CUDA
        cudatoolkit
        cudaPackages.cudnn
      ]
      ++ (with pkgs.vulkanPackages_latest; [
        vulkan-extension-layer
        vulkan-loader
        vulkan-tools
        vulkan-validation-layers
      ]);

    # NVIDIA驱动
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      package = pkgs.nvidia_cachyos;
      open = false;
      modesetting.enable = true;
      powerManagement.enable = true;
      dynamicBoost.enable = true;
      powerManagement.finegrained = false;
      nvidiaSettings = false;
    };

    hardware.nvidia-container-toolkit = {
      enable = true;
      mount-nvidia-executables = true;
      mount-nvidia-docker-1-directories = true;
    };

    nixpkgs.config.cudaSupport = true;
  };
}
