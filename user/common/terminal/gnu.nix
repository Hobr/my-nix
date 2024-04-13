{ pkgs, ... }: {
  home.packages = with pkgs; [
    coreutils-full
    gnumake
    gnused
    gnugrep
    gnutar
  ];
}
