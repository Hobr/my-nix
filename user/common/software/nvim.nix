{pkgs, ...}: {
  programs.neovim = {
    enable = false;
    package = pkgs.unstable.neovim-unwrapped;
    defaultEditor = true;

    # 快捷键
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    # 配置
    extraConfig = ''
      colorscheme catppuccin-latte
    '';
    extraLuaConfig = ''
      vim.cmd.colorscheme "catppuccin"
    '';
    # 插件
    plugins = with pkgs.vimPlugins; [catppuccin-nvim];
  };

  # NeoVide
  home.packages = with pkgs.unstable; [neovide lunarvim];
}
