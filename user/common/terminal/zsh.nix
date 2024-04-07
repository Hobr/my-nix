{
  pkgs,
  inputs,
  ...
}: {
  programs.zsh = {
    enable = true;
    package = pkgs.zsh;

    shellAliases = {
      pr = "proxychains4";
      rm = "trash-put";
      cat = "bat";
      v = "vim";
      reboot = "sudo systemctl reboot";
    };

    # 插件
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;
    syntaxHighlighting.enable = true;

    # 配置
    initExtraFirst = "LD_LIBRARY_PATH='$LD_LIBRARY_PATH:${pkgs.unstable.linuxPackages.nvidia_x11}/lib:${pkgs.ncurses5}/lib'\nsource ${inputs.catppuccin-zsh}/themes/catppuccin_latte-zsh-syntax-highlighting.zsh";
  };
}
