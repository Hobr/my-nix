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
      extraPackages = with pkgs; [
        intel-media-driver
        libva-vdpau-driver
        libvdpau-va-gl
        intel-compute-runtime
        intel-vaapi-driver
      ];
    };

    environment.systemPackages =
      with pkgs;
      [
        libva
        mesa
      ]
      ++ (with pkgs.vulkanPackages_latest; [
        vulkan-extension-layer
        vulkan-loader
        vulkan-tools
        vulkan-validation-layers
      ]);

    # GPU驱动
    services.xserver.videoDrivers = [
      "modesetting"
      "intel"
    ];
  };
}
