{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode.override (old: {
      # Wayland Fcitx5
      commandLineArgs = (old.commandLineArgs or [ ]) ++ [ "--enable-wayland-ime" ];
    });
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      # nix language
      bbenoist.nix
      # Color theme
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
    ];
    userSettings = {
      # Style
      "window.titleBarStyle" = "custom";
      "files.autoSave" = "afterDelay";
      "update.mode" = "none";
      "extensions.autoUpdate" = false;
      "editor.fontFamily" = "'Mononoki Nerd Font', 'Sarasa UI SC'";
      "terminal.integrated.fontFamily" = "'Mononoki Nerd Font', 'Sarasa UI SC'";
      "editor.fontSize" = 16;
      "workbench.colorTheme" = "Catppuccin Latte";
      "workbench.iconTheme" = "catppuccin-latte";

      # Git
      "git.confirmSync" = false;
      "git.enableSmartCommit" = true;
      "git.autofetch" = true;

      # Editor
      "diffEditor.ignoreTrimWhitespace" = false;
    };
    keybindings = [ ];
  };
}
