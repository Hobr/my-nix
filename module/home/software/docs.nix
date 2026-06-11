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
      # 文献
      zotero
      # 办公
      libreoffice
      # 阅读
      foliate
      # 学习
      anki-bin
      # 笔记
      obsidian
    ];
  };
}
