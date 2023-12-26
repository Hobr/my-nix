{pkgs,...}:
{
  home.packages = with pkgs.unstable; [
    wget
    fastfetch
  ];
}
