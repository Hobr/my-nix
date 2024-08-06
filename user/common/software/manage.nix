{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # 资源管理器
    nemo-with-extensions
    # 解压
    file-roller
    nemo-fileroller
  ];
}
