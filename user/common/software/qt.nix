{ pkgs, inputs, ... }:
{
  home.packages = with pkgs.unstable; [ qtcreator ];
  xdg.configFile = {
    "QtProject/qtcreator/themes/catppuccin-latte.creatortheme".source = "${inputs.catppuccin-qtcreator}/themes/catppuccin-latte.creatortheme";
    "QtProject/qtcreator/styles/catppuccin-latte.xml".source = "${inputs.catppuccin-qtcreator}/styles/catppuccin-latte.xml";
  };
}
