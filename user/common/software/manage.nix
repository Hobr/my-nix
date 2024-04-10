{pkgs, ...}: {
  home.packages = with pkgs.unstable; [
    # 资源管理器
    gnome.nautilus
    # 解压
    gnome.file-roller
    # 密码管理器
    bitwarden
  ];
}
