{pkgs, ...}: {
  i18n.inputMethod = {
    enabled = "fcitx5";

    # Fcitx5
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-anthy
      fcitx5-gtk
      fcitx5-configtool
    ];
  };
}
