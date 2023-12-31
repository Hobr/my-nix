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

  # Avizo
  services.avizo = {
    enable = true;

    settings = {
      default = {
        time = 1.0;
        y-offset = 0.5;
        fade-in = 0.1;
        fade-out = 0.2;
        padding = 10;
      };
    };
  };
}
