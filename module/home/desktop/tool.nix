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
    services.dunst = {
      enable = cfg.notice;
      iconTheme = {
        package = pkgs.catppuccin-papirus-folders;
        name = "Papirus";
      };
      settings = { };
    };

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
    # 鼠标
    home.pointerCursor = {
      package = inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default;
      name = "rose-pine-hyprcursor";
      size = 24;
      gtk.enable = true;
    };

    # 主题
    # GTK
    gtk = {
      enable = cfg.theme;

      # 主题
      theme = {
        name = "Catppuccin-Latte-Standard-Lavender-Light";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "lavender" ];
          size = "standard";
          tweaks = [ "normal" ];
          variant = "latte";
        };
      };

      # Icon
      iconTheme = {
        name = "Papirus";
        package = pkgs.catppuccin-papirus-folders.override {
          accent = "lavender";
          flavor = "latte";
        };
      };

      font = {
        name = "Sarasa UI SC";
        size = 12;
      };
    };

    xdg.configFile = mkIf cfg.theme {
      "gtk-4.0/assets".source =
        "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
      "gtk-4.0/gtk.css".source =
        "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
      "gtk-4.0/gtk-dark.css".source =
        "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
    };

    # QT
    qt = {
      enable = cfg.theme;
      platformTheme.name = "gtk3";
    };

    # 字体
    fonts.fontconfig.enable = true;
  };
}
