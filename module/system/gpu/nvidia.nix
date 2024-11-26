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
        version = "565.57.01";
        sha256_64bit = "sha256-buvpTlheOF6IBPWnQVLfQUiHv4GcwhvZW3Ks0PsYLHo=";
        sha256_aarch64 = "sha256-buvpTlheOF6IBPWnQVLfQUiHv4GcwhvZW3Ks0PsYLHo=";
        openSha256 = "sha256-/tM3n9huz1MTE6KKtTCBglBMBGGL/GOHi5ZSUag4zXA=";
        settingsSha256 = "sha256-kQsvDgnxis9ANFmwIwB7HX5MkIAcpEEAHc8IBOLdXvk=";
        persistencedSha256 = "sha256-E2J2wYYyRu7Kc3MMZz/8ZIemcZg68rkzvqEwFAL3fFs=";
        patchesOpen = [
          ./nvidia.patch
        ];
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
