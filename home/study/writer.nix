{ pkgs, lib, ... }:
{
  home.packages = with pkgs.unstable; lib.mkAfter [
    obsidian
    zotero
    anki

    libreoffice
    hunspell
    hunspellDicts.en_US
  ];
}
