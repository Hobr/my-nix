{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode.override (old: {
      # Wayland Fcitx5
      commandLineArgs = (old.commandLineArgs or []) ++ ["--enable-wayland-ime"];
    });
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    extensions = with pkgs.unstable.vscode-extensions; [
      # 界面
      ms-ceintl.vscode-language-pack-zh-hans
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      # Code
      visualstudioexptteam.vscodeintellicode
      editorconfig.editorconfig
      christian-kohler.path-intellisense
      # 功能
      formulahendry.code-runner
      esbenp.prettier-vscode
      ms-vscode-remote.remote-ssh
      usernamehw.errorlens
      # Git
      eamodio.gitlens
      donjayamanne.githistory
      # C++
      ms-vscode.cpptools
      ms-vscode.makefile-tools
      # Python
      ms-python.python
      ms-python.black-formatter
      ms-python.isort
      # Nix
      bbenoist.nix
      jnoortheen.nix-ide
      arrterian.nix-env-selector
      kamadorueda.alejandra
      mkhl.direnv
      # Ruby
      shopify.ruby-lsp
      # Markdown
      davidanson.vscode-markdownlint
      # Latex
      james-yu.latex-workshop
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
        "editor.defaultFormatter" = "kamadorueda.alejandra";
        "editor.formatOnSave" = true;
      };
    };
    keybindings = [];
  };
}
