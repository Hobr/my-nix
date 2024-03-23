{pkgs, ...}: {
  home.packages = with pkgs.unstable; [
    coreutils-full
    gnumake
    gnused
    gnugrep
    gnutar
  ];
}
