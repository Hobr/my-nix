{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.web.im;
in
{
  options.home.web.im.enable = mkEnableOption "im";

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      telegram-desktop
      wechat-uos
      (qq.override (old: {
        # Wayland Fcitx5
        commandLineArgs = (old.commandLineArgs or [ ]) ++ [ "--enable-wayland-ime" ];
      }))
    ];
  };
}
