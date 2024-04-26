{ pkgs, ... }: {
  home.packages = with pkgs; [
    obsidian
    zotero
    anki

    gnome.ghex
    charles

    libreoffice
    hunspell
    hunspellDicts.en_US
  ];
}
