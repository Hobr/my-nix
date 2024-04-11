{ pkgs, ... }: {
  home.packages = with pkgs.unstable; [
    obsidian
    zotero
    anki

    libreoffice
    hunspell
    hunspellDicts.en_US
  ];
}
