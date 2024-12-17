{
  home = {
    # 系统版本号
    stateVersion = "24.11";

    # 桌面
    desktop = {
      hypr.enable = true;
      waybar.enable = true;
      menu.enable = true;

      secure = {
        lock = true;
        logout = false;
      };

      tool = {
        notice = true;
        clipboard = true;
        xdg = true;
        pointer = true;
        theme = true;
      };
    };

    software = {
      terminal.enable = true;
    };

    web = {
      browser.enable = true;
      im.enable = true;
      mail.enable = true;
      download.enable = true;
    };

    dev = {
      git.enable = true;
      gpg.enable = true;

      editor = {
        vscode = true;
        nvim = true;
        emacs = true;
        qt = true;
      };
    };
  };
}
