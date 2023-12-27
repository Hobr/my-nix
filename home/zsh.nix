{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;

    # 插件
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./config;
        file = "p10k.zsh";
      }
    ];
  };
}
