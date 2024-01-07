{ pkgs, ... }:
{
  # Dunst
  services.dunst = {
    enable = true;
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
      size = "16x16";
    };

    settings = { };
  };
}
