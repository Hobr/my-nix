{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.home.software.zsh;
in
{
  options.home.software.zsh.enable = mkEnableOption "zsh";

  config = mkIf cfg.enable {
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

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
