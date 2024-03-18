{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    package = pkgs.unstable.kitty;
  };
}
