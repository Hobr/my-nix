{
  config,
  options,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  cfg = config.home.desktop.tool;
in
{
  options.home.desktop.tool = {
    clipboard = mkEnableOption "clipboard";
    notice = mkEnableOption "notice";
    xdg = mkEnableOption "xdg";
    pointer = mkEnableOption "pointer";
    theme = mkEnableOption "theme";
  };

  config = {
    # 粘贴板
    services.cliphist = {
      enable = cfg.clipboard;
      systemdTargets = [ "hyprland-session.target" ];
    };
    home.packages = optionals cfg.clipboard [ pkgs.wl-clipboard ];

    # 消息通知
    services.dunst.enable = cfg.notice;

    # XDG
    xdg = {
      enable = cfg.xdg;

      userDirs = {
        enable = cfg.xdg;

        # 目录
        createDirectories = cfg.xdg;
        desktop = "${config.home.homeDirectory}/Desktop";
        download = "${config.home.homeDirectory}/Download";
        documents = "${config.home.homeDirectory}/Document";
        pictures = "${config.home.homeDirectory}/Picture";
        videos = "${config.home.homeDirectory}/Video";
        music = "${config.home.homeDirectory}/Music";
        templates = "${config.home.homeDirectory}/Template";
      };
    };
  };
}
