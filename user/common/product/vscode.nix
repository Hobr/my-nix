{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.override (old: {
      # Wayland Fcitx5
      commandLineArgs = (old.commandLineArgs or [ ]) ++ [ "--enable-wayland-ime" ];
    });
  };
}
