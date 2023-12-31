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

  # Ripgrep(grep)
  programs.ripgrep.enable = true;

  # Bottom(top)
  programs.bottom = {
    enable = true;
    settings = { };
  };

  # Btop(top)
  programs.btop = {
    enable = true;
    settings = { };
  };

  # Htop(top)
  programs.htop = {
    enable = true;
    settings = { };
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

  # feh(图片查看器)
  programs.feh = {
    enable = true;
    buttons = { };
    keybindings = { };
  };

  # imv(图片查看器)
  programs.imv = {
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

  # 目录颜色
  programs.dircolors = {
    enable = true;
    enableZshIntegration = true;
    settings = { };
  };

  # Zoxide(cd)
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ ];
  };

  # nix-locate
  programs.nix-index = {
    enable = true;
    package = pkgs.nix-index;
    enableZshIntegration = true;
  };
}
