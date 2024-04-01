{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode.override (old: {
      # Wayland Fcitx5
      commandLineArgs = (old.commandLineArgs or []) ++ ["--enable-wayland-ime"];
    });
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      # Nix
      bbenoist.nix
      jnoortheen.nix-ide
      arrterian.nix-env-selector
      kamadorueda.alejandra
      mkhl.direnv
      # 主题
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      # Python
      ms-python.python
      ms-python.vscode-pylance
      ms-python.black-formatter
      ms-python.isort
      # Git
      eamodio.gitlens
    ];
    userSettings = {
      # 主题
      "window.titleBarStyle" = "custom";
      "files.autoSave" = "afterDelay";
      "update.mode" = "none";
      "extensions.autoUpdate" = false;

      # 字体
      "editor.fontFamily" = "'Mononoki Nerd Font', 'Sarasa UI SC'";
      "terminal.integrated.fontFamily" = "'Mononoki Nerd Font', 'Sarasa UI SC'";
      "editor.fontSize" = 16;

      # Catputtin
      "workbench.colorTheme" = "Catppuccin Latte";
      "workbench.iconTheme" = "catppuccin-latte";
      # 终端
      "terminal.integrated.minimumContrastRatio" = 1;

      # Git
      "git.confirmSync" = false;
      "git.enableSmartCommit" = true;
      "git.autofetch" = true;

      # 编辑器
      "diffEditor.ignoreTrimWhitespace" = false;
      "editor.semanticHighlighting.enabled" = true;
      "explorer.confirmDragAndDrop" = false;

      "[python]" = {
        "editor.defaultFormatter" = "ms-python.black-formatter";
        "editor.formatOnSave" = true;
      };

      "[nix]" = {
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
        "editor.formatOnSave" = true;
      };
    };
    keybindings = [];
  };
}
