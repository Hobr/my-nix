{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.software.docs;
in
{
  options.home.software.docs.enable = mkEnableOption "docs";

  config = mkIf cfg.enable {
    programs.sioyek = {
      enable = true;
      bindings = { };
      config = { };
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
  };
}
