{ pkgs, inputs, ... }:
{
  programs.zsh = {
    enable = true;
    package = pkgs.zsh;

    shellAliases = {
      pr = "proxychains4";
      rm = "trash-put";
      cat = "bat";
    };

    # 插件
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;
    syntaxHighlighting.enable = true;

    # 配置
    initExtraFirst = "source ${inputs.catppuccin-zsh}/themes/catppuccin_latte-zsh-syntax-highlighting.zsh";
  };
}
