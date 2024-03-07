{ pkgs,lib, ... }:
{
  i18n.inputMethod = {
    enabled = "fcitx5";

    # Fcitx5
    fcitx5.addons = with pkgs.unstable; [
      fcitx5-gtk
      fcitx5-configtool
      fcitx5-rime
      fcitx5-chinese-addons
      fcitx5-anthy
    ];
  };

  home.packages = with pkgs.unstable; lib.mkAfter [
    maliit-keyboard
  ]; 
}
