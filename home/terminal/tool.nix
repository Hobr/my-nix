{ pkgs, lib, ... }:
{
  # Bat(cat)
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [ prettybat batwatch batpipe batman batgrep batdiff ];

    # 配置
    themes = { };
    syntaxes = { };
    config = { };
  };

  # Zoxide(cd)
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ ];
  };

  # Broot(tree)
  programs.broot = {
    enable = true;
    enableZshIntegration = true;
    settings = { };
  };

  # eza(ls)
  programs.eza = {
    enable = true;
    enableAliases = true;
    git = true;
    icons = true;
    extraOptions = [ ];
  };

  # 目录颜色
  programs.dircolors = {
    enable = true;
    enableZshIntegration = true;
    settings = { };
  };

  # Ripgrep(grep)
  programs.ripgrep.enable = true;

  # Btop(top)
  programs.btop = {
    enable = true;
    settings = { };
  };

  # fzf(fd)
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # less
  programs.less.enable = true;

  # feh(图片查看器)
  programs.feh = {
    enable = true;
    buttons = { };
    keybindings = { };
  };

}
