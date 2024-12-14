{ pkgs, ... }:
{
  programs.sioyek = {
    enable = true;
    bindings = {
      "move_up" = "k";
      "move_down" = "j";
      "move_left" = "h";
      "move_right" = "l";
      "screen_down" = [
        "d"
        ""
      ];
      "screen_up" = [
        "u"
        ""
      ];
    };
    config = {
      "background_color" = "1.0 1.0 1.0";
      "text_highlight_color" = "1.0 0.0 0.0";
    };
  };

  home.packages = with pkgs; [
    hunspell
    hunspellDicts.en_US
    # 文献
    zotero
    paperlib
    # PDF翻译
    pdf-math-translate
    # 办公
    libreoffice
    # 阅读
    foliate
  ];
}
