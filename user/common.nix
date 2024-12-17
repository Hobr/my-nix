{
  home = {
    # 系统版本号
    stateVersion = "24.11";

    # 桌面
    desktop = {
      hypr.enable = true;
      waybar.enable = true;
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
  };
}
