{ pkgs, ... }: {
  home.packages = with pkgs; [
    gnome.ghex
    wvkbd
    squeekboard
    maliit-keyboard
    onboard
  ];
}
