{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.desktop.tool;
in
{
  options.home.desktop.tool = {
    clipboard = mkEnableOption "clipboard";
  };

  config = {
    # Clipboard
    services.cliphist = {
      enable = cfg.clipboard;
      systemdTarget = "hyprland-session.target";
    };
    home.packages = optionals cfg.clipboard [ pkgs.wl-clipboard ];
  };
}
