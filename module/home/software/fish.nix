{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.software.fish;
in
{
  options.home.software.fish.enable = mkEnableOption "fish";

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;

      shellAbbrs = {
        pr = "proxychains4";
        rm = "trash-put";
        cat = "bat";
        v = "vim";
      };

      interactiveShellInit = ''
        set -g fish_greeting
      '';

      plugins = [
        # 自动补全括号引号
        {
          name = "autopair.fish";
          src = pkgs.fishPlugins.autopair.src;
        }
        # 完成提示
        {
          name = "done";
          src = pkgs.fishPlugins.done.src;
        }
        # alias提示
        {
          name = "fish-you-should-use";
          src = pkgs.fishPlugins.fish-you-should-use.src;
        }
        # Man页面着色
        {
          name = "colored_man_pages";
          src = pkgs.fishPlugins.colored-man-pages.src;
        }
        # Bash兼容
        {
          name = "bass";
          src = pkgs.fishPlugins.bass.src;
        }
      ];
    };

    home.shell.enableFishIntegration = true;

    programs.starship = {
      enable = true;
      presets = [
        "nerd-font-symbols"
        "jetpack"
      ];
    };
  };
}
