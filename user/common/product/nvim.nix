{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    catppuccin.enable = true;
    # 快捷键
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  # NeoVide
  home.packages = with pkgs; [ neovide ];
}
