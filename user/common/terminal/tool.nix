{ pkgs, lib, ... }:
{
  # Bat(cat)
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.unstable.bat-extras; [ prettybat batwatch batpipe batman batgrep batdiff ];

    # 配置
    themes = { };
    syntaxes = { };
    config = { };
  };

  # Zoxide(cd)
  programs.zoxide = {
    enable = true;
    package = pkgs.unstable.zoxide;
    enableZshIntegration = true;
    options = [ ];
  };

  # Broot(tree)
  programs.broot = {
    enable = true;
    package = pkgs.unstable.broot;
    enableZshIntegration = true;
    settings = { };
  };

  # eza(ls)
  programs.eza = {
    enable = true;
    package = pkgs.unstable.eza;
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
  programs.ripgrep = {
    enable = true;
    package = pkgs.unstable.ripgrep;
  };

  # Btop(top)
  programs.btop = {
    enable = true;
    package = pkgs.unstable.btop;
    settings = { };
  };

  # fzf(fd)
  programs.fzf = {
    enable = true;
    package = pkgs.unstable.fzf;
    enableZshIntegration = true;
  };

  # less
  programs.less.enable = true;

  # feh(图片查看器)
  programs.feh = {
    enable = true;
    package = pkgs.unstable.feh;
    buttons = { };
    keybindings = { };
  };
}
