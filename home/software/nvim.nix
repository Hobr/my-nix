{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
    defaultEditor = true;

    # 快捷键
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    # 插件
    plugins = [ ];
  };
}
