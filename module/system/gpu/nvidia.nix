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

    environment.systemPackages = with pkgs; [
      # Vulkan
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
      vulkan-tools
      libva
      mesa

      # NVTop
      nvtopPackages.nvidia
    ];

    # NVIDIA驱动
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "560.31.02";
        sha256_64bit = "sha256-0cwgejoFsefl2M6jdWZC+CKc58CqOXDjSi4saVPNKY0=";
        sha256_aarch64 = "sha256-m7da+/Uc2+BOYj6mGON75h03hKlIWItHORc5+UvXBQc=";
        openSha256 = "sha256-X5UzbIkILvo0QZlsTl9PisosgPj/XRmuuMH+cDohdZQ=";
        settingsSha256 = "sha256-A3SzGAW4vR2uxT1Cv+Pn+Sbm9lLF5a/DGzlnPhxVvmE=";
        persistencedSha256 = "sha256-BDtdpH5f9/PutG3Pv9G4ekqHafPm3xgDYdTcQumyMtg=";
        preInstall = ''
          rm -f ./libnvidia-egl-wayland.so*
          cp ${pkgs.egl-wayland}/lib/libnvidia-egl-wayland.so.1.* .
          chmod 777 ./libnvidia-egl-wayland.so.1.*
        '';
      };
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
