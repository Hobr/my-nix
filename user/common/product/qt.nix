{ pkgs, ... }:
{
  home.packages = with pkgs; [ qtcreator ];
}
