{
  config,
  options,
  lib,
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
