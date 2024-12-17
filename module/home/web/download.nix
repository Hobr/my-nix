{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.home.software.download;
in
{
  options.home.software.download.enable = mkEnableOption "download";

  config = mkIf cfg.enable {
    # Aria
    programs.aria2 = {
      enable = true;
    };

    home.packages = with pkgs; [ qbittorrent-enhanced ];
  };
}
