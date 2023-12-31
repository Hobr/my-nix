{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    userSettings = {
      "window.titleBarStyle" = "custom";
      "files.autoSave" = "afterDelay";

      "git.confirmSync" = false;
      "git.enableSmartCommit" = true;

      "diffEditor.ignoreTrimWhitespace" = false;
    };
    keybindings = [ ];
  };
}
