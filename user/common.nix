{
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.stylix.homeManagerModules.stylix

    outputs.homeManagerModules
  ];

  home = {
    # 系统版本号
    stateVersion = "25.05";

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
      mail.enable = true;
      music.enable = true;
      download.enable = true;
      sync.enable = true;
    };

    software = {
      docs.enable = true;
      terminal.enable = true;
      zsh.enable = true;
    };

    media = {
      audio.enable = true;
      video.enable = true;
      image.enable = true;
    };

    dev = {
      git.enable = true;
      gpg.enable = true;
      nix.enable = true;
      direnv.enable = true;
      util.enable = true;

      editor = {
        vscode = true;
        nvim = true;
        emacs = true;
      };
    };

    util = {
      audio.enable = true;
      gnu.enable = true;
      ssh.enable = true;
      disk.enable = true;
      file.enable = true;
      cli.enable = true;
    };
  };

  # 主题
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

    targets.vscode.profileNames = [ "default" ];
  };
}
