{ config, ... }:
{
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
}