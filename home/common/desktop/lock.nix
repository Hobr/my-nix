{ pkgs, ... }:
{
  programs.swaylock = {
    enable = true;
    package = pkgs.unstable.swaylock-effects;
    settings = { };
  };
}
