{ pkgs, lib, ... }:
{
  home.packages = with pkgs.unstable; lib.mkAfter [
    obsidian
    zotero
    anki
    p3x-onenote

    libreoffice
    hunspell
    hunspellDicts.en_US
  ];
}
