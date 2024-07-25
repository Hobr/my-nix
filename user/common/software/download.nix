{ pkgs, ... }:
{
  # Aria
  programs.aria2 = {
    enable = true;
  };

  home.packages = with pkgs; [ qbittorrent-enhanced ];
}
