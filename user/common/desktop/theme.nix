{ pkgs, config, ... }:
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
    package = pkgs.unstable.catppuccin-cursors.latteRosewater;
    name = "Catppuccin-Latte-Rosewater-Cursors";
    size = 20;
    gtk.enable = true;
  };

  # GTK
  gtk = {
    enable = true;

    # 主题
    theme = {
      name = "Catppuccin-Latte-Standard-Rosewater-Light";
      package = pkgs.unstable.catppuccin-gtk.override {
        accents = [ "rosewater" ];
        size = "standard";
        tweaks = [ "normal" ];
        variant = "latte";
      };
    };

    # Icon
    iconTheme = {
      name = "Papirus";
      package = pkgs.unstable.catppuccin-papirus-folders.override {
        accent = "rosewater";
        flavor = "latte";
      };
    };
  };

  # QT
  qt = {
    enable = true;
    platformTheme = "gtk3";
  };

  # 字体
  fonts.fontconfig.enable = true;
  gtk.font = {
    name = "Sarasa UI SC";
    size = 11;
  };

  # 深色模式
  services.darkman = {
    enable = true;
    package = pkgs.unstable.darkman;
    lightModeScripts = { };
    darkModeScripts = { };
    settings = {
      usegeoclue = false;
    };
  };
}
