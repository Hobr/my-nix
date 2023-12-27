{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;
    enableUpdateCheck = false;
  };

  # Wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
