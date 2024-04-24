{ pkgs, ... }: {
  home.packages = with pkgs; [
    obsidian
    zotero
    anki

    gnome.ghex

    libreoffice
    hunspell
    hunspellDicts.en_US
  ];
}
