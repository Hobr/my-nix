{ pkgs, lib, ... }:
{
  home.packages = with pkgs.unstable; lib.mkAfter [
    # 资源管理器
    xplorer
    gnome.nautilus

    # 解压
    gnome.file-roller
  ];
}
