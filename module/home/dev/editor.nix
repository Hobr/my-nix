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
      extraPackages = epkgs: [ epkgs.magit ];
    };

    # Visual Studio Code
    programs.vscode = {
      enable = cfg.vscode;
      package = pkgs.vscode.override (old: {
        # Wayland Fcitx5
        commandLineArgs = (old.commandLineArgs or [ ]) ++ [ "--enable-wayland-ime" ];
      });

      profiles.default.userSettings = {
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
        "[markdown]"."diffEditor.ignoreTrimWhitespace" = false;

        "[ruby]"."editor.defaultFormatter" = "Shopify.ruby-lsp";
        "[ruby]"."editor.formatOnSave" = true;
        "[ruby]"."editor.formatOnType" = true;
        "[ruby]"."editor.tabSize" = 2;
        "[ruby]"."editor.insertSpaces" = true;
        "[ruby]"."files.trimTrailingWhitespace" = true;
        "[ruby]"."files.insertFinalNewline" = true;
        "[ruby]"."files.trimFinalNewlines" = true;
        "[ruby]"."editor.rulers" = [ 120 ];
        "[ruby]"."editor.semanticHighlighting.enabled" = true;

        "[python]"."diffEditor.ignoreTrimWhitespace" = false;
        "[typst]"."editor.wordSeparators" = "`~!@#$%^&*()=+[{]}\\|;:'\",.<>/?";
        "[typst-code]"."editor.wordSeparators" = "`~!@#$%^&*()=+[{]}\\|;:'\",.<>/?";

        "breadcrumbs.enabled" = true;
        "diffEditor.maxComputationTime" = 0;
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.formatOnType" = false;
        "editor.inlineSuggest.enabled" = true;
        "editor.inlineSuggest.showToolbar" = "always";
        "editor.minimap.autohide" = true;
        "editor.minimap.showSlider" = "always";
        "editor.renderControlCharacters" = true;
        "editor.renderWhitespace" = "all";
        "editor.suggestSelection" = "first";
        "editor.unicodeHighlight.nonBasicASCII" = false;
        "editor.wordWrap" = "on";
        "eslint.format.enable" = true;
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "extensions.ignoreRecommendations" = false;
        "files.autoSave" = "onFocusChange";
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;
        "python.languageServer" = "Pylance";
        "redhat.telemetry.enabled" = true;
        "security.workspace.trust.untrustedFiles" = "open";
        "stylua.styluaPath" = "/usr/sbin/stylua";
        "terminal.integrated.copyOnSelection" = true;
        "terminal.integrated.cursorBlinking" = true;
        "terminal.integrated.cursorStyle" = "line";
        "vsintellicode.modify.editor.suggestSelection" = "automaticallyOverrodeDefaultValue";
        "window.menuBarVisibility" = "compact";
        "window.titleBarStyle" = "custom";
        "workbench.productIconTheme" = "fluent-icons";
        "workbench.startupEditor" = "newUntitledFile";
        "terminal.integrated.enableVisualBell" = true;
        "workbench.iconTheme" = "catppuccin-latte";
        "tinymist.formatterMode" = "typstyle";
        "diffEditor.ignoreTrimWhitespace" = false;
        "github.copilot.editor.enableAutoCompletions" = true;
        "gitlens.views.commitDetails.files.layout" = "tree";
        "window.commandCenter" = false;
        "workbench.layoutControl.enabled" = false;
        "diffEditor.renderSideBySide" = true;
        "update.mode" = "none";

        "terminal.integrated.commandsToSkipShell" = [
          "github.copilot.terminal.suggestCommand"
          "language-julia.interrupt"
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

    home.packages = with pkgs; [
      nano
      (if cfg.nvim then neovide else null)
      (if cfg.qt then qtcreator else null)
    ];
  };
}
