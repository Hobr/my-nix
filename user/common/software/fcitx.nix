{ pkgs, inputs, ... }:
{
  i18n.inputMethod = {
    enabled = "fcitx5";

    # Fcitx5
    fcitx5.addons = with pkgs; [
      (fcitx5-rime.override { rimeDataPkgs = [ inputs.hobr.packages.${pkgs.system}.rime-ice ]; })
      fcitx5-mozc
      fcitx5-chinese-addons
      fcitx5-gtk
      fcitx5-configtool
    ];
  };

  # 触屏键盘
  home.packages = [ pkgs.wvkbd ];
}
