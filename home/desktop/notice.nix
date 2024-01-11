{ pkgs, ... }:
{
  # Dunst
  services.dunst = {
    enable = true;
    iconTheme = {
      package = pkgs.unstable.catppuccin-papirus-folders;
      name = "Papirus";
    };

    settings = { };
  };
}
