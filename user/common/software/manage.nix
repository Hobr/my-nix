{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # 资源管理器
    gnome.nautilus

    # 解压
    gnome.file-roller
  ];
}
