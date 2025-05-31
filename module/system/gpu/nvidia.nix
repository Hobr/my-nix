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

        # CUDA
        cudatoolkit
        cudaPackages.cudnn
      ]
      ++ (with vulkanPackages_latest; [
        vulkan-loader
        vulkan-validation-layers
        vulkan-extension-layer
        vulkan-tools
      ]);

    # NVIDIA驱动
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia =
      let
        # Preferred NVIDIA Version
        nvidiaPackage = config.boot.kernelPackages.nvidiaPackages.mkDriver {
          version = "575.57.08";
          sha256_64bit = "sha256-KqcB2sGAp7IKbleMzNkB3tjUTlfWBYDwj50o3R//xvI=";
          sha256_aarch64 = "sha256-VJ5z5PdAL2YnXuZltuOirl179XKWt0O4JNcT8gUgO98=";
          openSha256 = "sha256-DOJw73sjhQoy+5R0GHGnUddE6xaXb/z/Ihq3BKBf+lg=";
          settingsSha256 = "sha256-AIeeDXFEo9VEKCgXnY3QvrW5iWZeIVg4LBCeRtMs5Io=";
          persistencedSha256 = "sha256-Len7Va4HYp5r3wMpAhL4VsPu5S0JOshPFywbO7vYnGo=";

          patches = [ gpl_symbols_linux_615_patch ];
        };

        gpl_symbols_linux_615_patch = pkgs.fetchpatch {
          url = "https://github.com/CachyOS/kernel-patches/raw/914aea4298e3744beddad09f3d2773d71839b182/6.15/misc/nvidia/0003-Workaround-nv_vm_flags_-calling-GPL-only-code.patch";
          hash = "sha256-YOTAvONchPPSVDP9eJ9236pAPtxYK5nAePNtm2dlvb4=";
          stripLen = 1;
          extraPrefix = "kernel/";
        };
      in
      {
        package = nvidiaPackage;
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

    nixpkgs.config = {
      cudaSupport = true;
      cudaCapabilities = [ "8.6" ];
      cudaForwardCompat = false;
    };
  };
}
