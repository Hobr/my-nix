{
  programs.zsh = {
    enable = true;

    shellAliases = {
      pr = "proxychains4";
      rm = "trash-put";
      cat = "bat";
      v = "vim";
    };

    # 插件
    autosuggestion.enable = true;
    enableCompletion = true;
    autocd = true;
    syntaxHighlighting.enable = true;
  };
}
