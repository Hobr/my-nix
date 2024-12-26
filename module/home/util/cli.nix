{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.util.cli;
in
{
  options.home.util.cli.enable = mkEnableOption "cli";

  config = mkIf cfg.enable {
    # Bat(cat)
    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        prettybat
        batwatch
        batpipe
        batman
        batgrep
        batdiff
      ];
    };

    # Zoxide(cd)
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ ];
    };

    # Broot(tree)
    programs.broot = {
      enable = true;
      enableZshIntegration = true;
      settings = { };
    };

    # eza(ls)
    programs.eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
      icons = "auto";
      extraOptions = [ ];
    };

    # 目录颜色
    programs.dircolors = {
      enable = true;
      enableZshIntegration = true;
      settings = { };
    };

    # Ripgrep(grep)
    programs.ripgrep = {
      enable = true;
    };

    # Btop(top)
    programs.btop = {
      enable = true;
      settings = {
        update_ms = 500;
      };
    };
    # fzf(fd)
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    # less
    programs.less.enable = true;

    # feh(图片查看器)
    programs.feh = {
      enable = true;
      buttons = { };
      keybindings = { };
    };

    # Nix-index
    programs.nix-index = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.info.enable = true;

    home.packages = with pkgs.small; [
      iftop

      nitch
      fastfetch
      xorg.xlsclients
      xorg.xset

      brightnessctl
      trash-cli

      sd
      ranger
      dialog

      p7zip
      zip
      unzip
    ];
  };
}
