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
        batdiff
      ];
    };

    # Zoxide(cd)
    programs.zoxide.enable = true;

    # Broot(tree)
    programs.broot.enable = true;

    # eza(ls)
    programs.eza = {
      enable = true;
      git = true;
      icons = "auto";
    };

    # 目录颜色
    programs.dircolors.enable = true;

    # Ripgrep(grep)
    programs.ripgrep.enable = true;

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
    };

    # less
    programs.less.enable = true;

    # feh(图片查看器)
    programs.feh = {
      enable = true;

      buttons = {
        prev_img = [
          3
          "C-3"
        ];
        zoom_in = 4;
        zoom_out = "C-4";
      };

      keybindings = {
        prev_img = [
          "h"
          "Left"
        ];
        zoom_in = "plus";
        zoom_out = "minus";
      };
    };

    # Nix-index
    programs.nix-index.enable = true;

    # Ranger
    programs.ranger.enable = true;

    # Fastfetch
    programs.fastfetch.enable = true;

    programs.info.enable = true;

    home.packages = with pkgs; [
      iftop
      screen
      nitch

      brightnessctl
      trash-cli

      sd
      dialog

      p7zip
      zip
      unzip
      rar

      openssl
      inetutils
    ];
  };
}
