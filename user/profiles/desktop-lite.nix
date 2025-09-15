# Desktop user profile for portable laptops with lightweight software
{
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  imports = [
    ./base.nix
    inputs.stylix.homeModules.stylix
  ];

  home = {
    proxy.enable = true;

    desktop = {
      hypr.enable = true;
      waybar.enable = true;
      menu.enable = true;
      ime.enable = true;

      tool = {
        clipboard = true;
        notice = true;
        xdg = true;
        pointer = true;
        theme = true;
      };

      secure = {
        lock = true;
        logout = true;
      };
    };

    web = {
      browser.enable = true;
      im.enable = true;
      mail.enable = false;
      music.enable = true;
      download.enable = true;
      sync.enable = false;
    };

    software = {
      docs.enable = true;
    };

    media = {
      audio.enable = true;
      video.enable = true;
      image.enable = true;
    };

    dev = {
      editor = {
        vscode = true;
        nvim = true;
        emacs = false;
      };
    };

    util = {
      audio.enable = true;
    };

    # 便携本减少专业软件
    pro = {
      audio.enable = true;
      video.enable = false;  # 减少视频处理软件
      image.enable = true;
      obs.enable = false;   # 不需要录屏软件
      electron.enable = false;  # 减少大型 Electron 应用
    };
  };

  # 主题 - 与桌面版相同
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/sakura.yaml";

    # 指针
    cursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
    };

    # 图标
    iconTheme = {
      enable = true;
      dark = "Papirus";
      light = "Papirus";
      package = pkgs.catppuccin-papirus-folders.override {
        accent = "lavender";
        flavor = "latte";
      };
    };

    # 字体
    fonts = {
      sizes = {
        # 程序
        applications = 12;
        # 桌面
        desktop = 10;
        # 弹出
        popups = 10;
        # 终端
        terminal = 12;
      };

      serif = {
        package = pkgs.sarasa-gothic;
        name = "Sarasa UI SC";
      };

      sansSerif = {
        package = pkgs.sarasa-gothic;
        name = "Sarasa UI SC";
      };

      monospace = {
        package = pkgs.sarasa-gothic;
        name = "Sarasa Mono SC";
      };

      emoji = {
        package = pkgs.twitter-color-emoji;
        name = "Twemoji";
      };
    };
  };
}