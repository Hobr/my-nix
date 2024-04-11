{ pkgs, inputs, ... }: {
  # Bat(cat)
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.unstable.bat-extras; [
      prettybat
      batwatch
      batpipe
      batman
      batgrep
      batdiff
    ];

    # 配置
    config = { theme = "catppuccin"; };
    themes.catppuccin.src =
      "${inputs.catppuccin-bat}/themes/Catppuccin Latte.tmTheme";
    syntaxes = { };
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
    settings = {
      color_theme = "catppuccin_latte";
      update_ms = 500;
    };
  };
  xdg.configFile."btop/themes/catppuccin_latte.theme".source =
    "${inputs.catppuccin-btop}/themes/catppuccin_latte.theme";

  # fzf(fd)
  programs.fzf = {
    enable = true;
    package = pkgs.unstable.fzf;
    enableZshIntegration = true;
    colors = {
      bg = "#eff1f5";
      "bg+" = "#ccd0da";
      fg = "#4c4f69";
      "fg+" = "#4c4f69";
      hl = "#d20f39";
      "hl+" = "#d20f39";
      spinner = "#dc8a78";
      header = "#d20f39";
      info = "#8839ef";
      pointer = "#dc8a78";
      marker = "#dc8a78";
      prompt = "#8839ef";
    };
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
