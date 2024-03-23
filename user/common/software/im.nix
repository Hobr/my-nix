{pkgs, ...}: {
  home.packages = with pkgs.unstable; [
    qq
    telegram-desktop
    element-desktop
  ];
}
