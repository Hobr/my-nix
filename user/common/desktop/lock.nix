{ pkgs, ... }:
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {
      screenshots = true;
      clock = true;
      fade-in = 0.2;

      indicator = true;
      indicator-radius = 100;
      indicator-thickness = 7;
    };
  };
}
