{ config, lib, pkgs, ... }:
{
  # OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Vulkan
  environment.systemPackages = with pkgs.unstable; lib.mkAfter [
    vulkan-loader
    vulkan-validation-layers
    vulkan-extension-layer
    vulkan-tools
    libva
    mesa
  ];

  # GPU驱动
  services.xserver.videoDrivers = [ "intel" ];
}
