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
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  # GTK
  gtk = {
    enable = true;

    # 主题
    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    # Icon
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

  # QT
  qt = {
    enable = true;
    platformTheme = "gtk3";
    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita-dark";
    };
  };

  # 字体
  fonts.fontconfig.enable = true;
  gtk.font = {
    name = "Sans";
    size = 11;
  };

  # 深色模式
  services.darkman = {
    enable = true;
    lightModeScripts = { };
    darkModeScripts = { };
    settings = {
      usegeoclue = false;
    };
  };

  # nwg-look
  home.packages = with pkgs.unstable; lib.mkAfter [ nwg-look ];
}
