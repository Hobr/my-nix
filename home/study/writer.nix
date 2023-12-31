{ pkgs, lib, ... }:
{
  home.packages = with pkgs.unstable; lib.mkAfter [
    #obsidian
    zotero

    libreoffice
    hunspell
    hunspellDicts.en_US
  ];
}
