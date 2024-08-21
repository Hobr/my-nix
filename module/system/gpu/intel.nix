{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.sys.gpu.intel;
in
{
  options.sys.gpu.intel.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    # OpenGL
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiVdpau
        libvdpau-va-gl
        intel-compute-runtime
        vaapiIntel
      ];
    };

    # Vulkan
    environment.systemPackages = with pkgs; [
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
      vulkan-tools
      libva
      mesa
    ];

    # GPU驱动
    services.xserver.videoDrivers = [
      "modesetting"
      "intel"
    ];
  };
}
