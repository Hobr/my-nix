{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;

    shellAliases = {
      pr = "proxychains4";
      rm = "trash-put";
    };
    # 配置
    #    initExtra = ''
    #      bindkey "''${key[Backspace]}" backward-delete-char
    #      bindkey "''${key[Insert]}" overwrite-mode
    #      bindkey "''${key[Home]}" beginning-of-line
    #      bindkey "''${key[PageUp]}" up-line-or-history
    #      bindkey "''${key[Delete]}" delete-char
    #      bindkey "''${key[End]}" end-of-line
    #      bindkey "''${key[PageDown]}" down-line-or-history
    #      bindkey "''${key[Up]}" up-line-or-search
    #      bindkey "''${key[Left]}" backward-char
    #      bindkey "''${key[Down]}" down-line-or-search
    #      bindkey "''${key[Right]}" forward-char
    #    '';

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
        src = ./zsh;
        file = "p10k.zsh";
      }
    ];
  };
}
