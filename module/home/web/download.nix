{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.web.download;
in
{
  options.home.web.download.enable = mkEnableOption "download";

  config = mkIf cfg.enable {
    # Aria
    programs.aria2 = {
      enable = true;
    };

    home.packages = with pkgs.small; [
      qbittorrent-enhanced
      wget
      axel
    ];
  };
}
