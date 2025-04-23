{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.desktop.ime;
in
{
  options.home.desktop.ime.enable = mkEnableOption "ime";

  config = mkIf cfg.enable {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          (fcitx5-rime.override { rimeDataPkgs = [ rime-ice ]; })
          fcitx5-mozc
          fcitx5-chinese-addons
          fcitx5-gtk
          fcitx5-configtool
          fcitx5-material-color
        ];
      };
    };

    # 触屏键盘
    home.packages = [ pkgs.wvkbd ];
  };
}
