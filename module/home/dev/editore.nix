{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.home.dev.editor;
in
{
  options.home.dev.editor = {
    vscode = mkEnableOption "vscode";
    nvim = mkEnableOption "nvim";
    emacs = mkEnableOption "emacs";
    qt = mkEnableOption "qt";
  };

  config = {
    # NeoVim
    programs.neovim = {
      enable = cfg.nvim;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };

    # Emacs
    programs.emacs = {
      enable = cfg.emacs;
      extraPackages = epkgs: [ epkgs.magit ];
    };

    # Visual Studio Code
    programs.vscode = {
      enable = cfg.vscode;
      package = pkgs.vscode.override (old: {
        # Wayland Fcitx5
        commandLineArgs = (old.commandLineArgs or [ ]) ++ [ "--enable-wayland-ime" ];
      });
    };

    home.packages = with pkgs; [
      (if cfg.nvim then neovide else null)
      (if cfg.qt then qtcreator else null)
    ];
  };
}
