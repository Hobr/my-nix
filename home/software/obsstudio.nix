{ pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    package = pkgs.unstable.obs-studio;
    plugins = with pkgs.unstable.obs-studio-plugins; [ obs-multi-rtmp ];
  };
}
