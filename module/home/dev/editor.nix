{
  config,
  options,
  lib,
  pkgs,
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
      package = pkgs.emacs30;
    };

    # Visual Studio Code
    programs.vscode = {
      enable = cfg.vscode;
      mutableExtensionsDir = false;

      profiles.default = {
        enableExtensionUpdateCheck = false;
        enableUpdateCheck = false;
        enableMcpIntegration = true;

        extensions =
          with pkgs.vscode-marketplace;
          with pkgs.vscode-marketplace-release;
          [
            # 显示
            miguelsolorio.fluent-icons
            ms-ceintl.vscode-language-pack-zh-hans
            wayou.vscode-todo-highlight
            albert.tabout
            usernamehw.errorlens

            # 工具
            ms-vscode.remote-server
            ms-vscode-remote.remote-ssh
            ms-vsliveshare.vsliveshare
            christian-kohler.path-intellisense
            google.gemini-cli-vscode-ide-companion

            # 环境
            mkhl.direnv
            formulahendry.code-runner
            editorconfig.editorconfig
            esbenp.prettier-vscode

            # Git
            eamodio.gitlens
            donjayamanne.githistory

            # Rust
            rust-lang.rust-analyzer
            cordx56.rustowl-vscode
            drkryz.rustautomod
            splo.vscode-bevy-inspector
            dioxuslabs.dioxus

            # Python
            ms-python.python
            ms-python.vscode-pylance
            ms-python.isort
            ms-python.debugpy
            charliermarsh.ruff

            # CPP
            ms-vscode.cpptools
            ms-vscode.cpptools-extension-pack
            jeff-hykin.better-cpp-syntax
            ms-vscode.cpptools-themes

            # JS
            firefox-devtools.vscode-firefox-debug
            vue.volar
            dbaeumer.vscode-eslint

            # Golang
            golang.go

            # Nix
            jnoortheen.nix-ide
            arrterian.nix-env-selector

            # Typst
            myriad-dreamin.tinymist

            # Markdown
            davidanson.vscode-markdownlint

            # Docker
            ms-azuretools.vscode-docker

            # Makefile
            ms-vscode.makefile-tools

            # Stylua
            johnnymorganz.stylua

            # Fountain
            piersdeseilligny.betterfountain

            # Yaml
            redhat.vscode-yaml

            # Toml
            tombi-toml.tombi

            # WIT
            bytecodealliance.wit-idl

            # XML
            dotjoshjohnson.xml

            # PDF
            tomoki1207.pdf

            # Just
            nefrob.vscode-just-syntax

            # Fortran
            fortran-lang.linter-gfortran

            # Copilot
            github.copilot
            github.copilot-chat
          ];

        userSettings = {
          "[c]"."editor.defaultFormatter" = "ms-vscode.cpptools";
          "[cpp]"."editor.defaultFormatter" = "ms-vscode.cpptools";
          "[css]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[html]"."editor.defaultFormatter" = "vscode.html-language-features";
          "[javascript]"."editor.defaultFormatter" = "vscode.typescript-language-features";
          "[json]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[jsonc]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[lua]"."editor.defaultFormatter" = "JohnnyMorganz.stylua";
          "[yaml]"."editor.defaultFormatter" = "redhat.vscode-yaml";

          "[markdown]"."editor.defaultFormatter" = "DavidAnson.vscode-markdownlint";

          "[typst]"."editor.wordSeparators" = "`~!@#$%^&*()=+[{]}\\|;:'\",.<>/?";
          "[typst-code]"."editor.wordSeparators" = "`~!@#$%^&*()=+[{]}\\|;:'\",.<>/?";

          "editor.cursorSmoothCaretAnimation" = "on";
          "editor.formatOnType" = false;
          "editor.inlineSuggest.enabled" = true;
          "editor.inlineSuggest.showToolbar" = "always";
          "editor.minimap.autohide" = "mouseover";
          "editor.minimap.showSlider" = "always";
          "editor.renderControlCharacters" = true;
          "editor.renderWhitespace" = "all";
          "editor.suggestSelection" = "first";
          "editor.unicodeHighlight.nonBasicASCII" = false;
          "editor.wordWrap" = "on";

          "terminal.integrated.copyOnSelection" = true;
          "terminal.integrated.cursorBlinking" = true;
          "terminal.integrated.cursorStyle" = "line";
          "terminal.integrated.enableVisualBell" = true;

          "diffEditor.maxComputationTime" = 0;
          "diffEditor.ignoreTrimWhitespace" = false;
          "diffEditor.renderSideBySide" = false;
          "diffEditor.hideUnchangedRegions.enabled" = true;

          "window.menuBarVisibility" = "compact";
          "window.titleBarStyle" = "custom";
          "window.commandCenter" = false;

          "workbench.productIconTheme" = "fluent-icons";
          "workbench.startupEditor" = "newUntitledFile";
          "workbench.layoutControl.enabled" = false;

          "git.autofetch" = true;
          "git.confirmSync" = false;
          "git.enableSmartCommit" = true;

          "explorer.confirmDelete" = false;
          "explorer.confirmDragAndDrop" = false;

          "extensions.ignoreRecommendations" = false;
          "files.autoSave" = "onFocusChange";
          "security.workspace.trust.untrustedFiles" = "open";
          "update.mode" = "none";

          "github.copilot.nextEditSuggestions.enabled" = true;
          "gitlens.views.commitDetails.files.layout" = "tree";

          "python.languageServer" = "Pylance";
          "tinymist.formatterMode" = "typstyle";
          "eslint.format.enable" = true;
          "breadcrumbs.enabled" = true;
          "redhat.telemetry.enabled" = true;

          "terminal.integrated.commandsToSkipShell" = [
            "github.copilot.terminal.suggestCommand"
          ];

          "github.copilot.enable" = {
            "*" = true;
            "plaintext" = false;
            "markdown" = true;
            "scminput" = false;
          };

          "accessibility.signals.terminalBell" = {
            "sound" = "on";
          };
        };
      };
    };

    home.packages = with pkgs; [
      nano
      gemini-cli
      github-copilot-cli
      (if cfg.nvim then neovide else null)
    ];
  };
}
