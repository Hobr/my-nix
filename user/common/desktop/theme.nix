{
  pkgs,
  inputs,
  config,
  ...
}:
{
  # XDG
  xdg = {
    enable = true;

    userDirs = {
      enable = true;

      # 目录
      createDirectories = true;
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

  # GTK
  gtk = {
    enable = true;

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
  };

  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  # QT
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
  };

  # 字体
  fonts.fontconfig.enable = true;

  gtk.font = {
    name = "Sarasa UI SC";
    size = 12;
  };
}
