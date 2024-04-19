{ pkgs, config, ... }: {
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

  # GTK
  gtk = {
    enable = true;
    catppuccin.enable = true;

    # Icon
    iconTheme = {
      name = "Papirus";
      package = pkgs.catppuccin-papirus-folders.override {
        accent = "lavender";
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
    size = 12;
  };
}
