# Template for desktop user configuration (full software suite)
# Copy this file and customize for your user
{ pkgs, ... }:
{
  imports = [ ./profiles/desktop-full.nix ];

  home = {
    username = "<USERNAME>";
    homeDirectory = "/home/<USERNAME>";

    # 设备特定的桌面配置
    desktop = {
      hypr = {
        nvidia = true; # 根据硬件调整为 true/false
        monitor = [
          # 根据显示器配置调整
          "DP-1,2560x1440@180,0x0,1"
          "eDP-1,2560x1440@165,auto,1.25"
        ];
      };
    };
  };

  # 壁纸 (可选)
  stylix.image = pkgs.fetchurl {
    url = "<WALLPAPER_URL>";
    hash = "<WALLPAPER_HASH>";
  };

  # NVIDIA 配置 (如果需要)
  nixpkgs.config = {
    cudaSupport = true;
    cudaCapabilities = [ "8.6" ]; # 根据GPU调整
    cudaForwardCompat = false;
  };
}