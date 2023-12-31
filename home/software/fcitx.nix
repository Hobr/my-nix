{ pkgs, ... }:
{
  i18n.inputMethod = {
    enabled = "fcitx5";

    # Fcitx5
    fcitx5.addons = [ pkgs.fcitx5-rime ];
  };
}
