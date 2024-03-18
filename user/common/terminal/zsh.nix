{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    package = pkgs.zsh;

    shellAliases = {
      pr = "proxychains4";
      rm = "trash-put";
    };

    # 插件
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
  };
}
