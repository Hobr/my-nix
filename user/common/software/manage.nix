{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # 资源管理器
    cinnamon.nemo-with-extensions
    # 解压
    gnome.file-roller
    cinnamon.nemo-fileroller
  ];
}
