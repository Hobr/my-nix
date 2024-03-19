{ pkgs, inputs, ... }:
{
  programs.swaylock = {
    enable = true;
    package = pkgs.unstable.swaylock-effects;
    #settings = {
    #  clock = true;
    #  datestr = "";
    #  screenshots = true;

    #  indicator = true;
    #  indicator-radius = 100;
    #  indicator-thickness = 7;
    #};
  };

  xdg.configFile."swaylock/config".source = "${inputs.catppuccin-swaylock}/themes/latte.conf";
}
