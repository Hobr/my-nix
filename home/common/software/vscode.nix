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
    userSettings = {
      "window.titleBarStyle" = "custom";
      "files.autoSave" = "afterDelay";

      "git.confirmSync" = false;
      "git.enableSmartCommit" = true;
      "git.autofetch" = true;

      "diffEditor.ignoreTrimWhitespace" = false;
    };
    keybindings = [ ];
  };
}
