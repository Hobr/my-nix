{ pkgs, ... }: {
  home.packages = with pkgs; [
    obsidian
    zotero
    anki

    libreoffice
    hunspell
    hunspellDicts.en_US
  ];
}
