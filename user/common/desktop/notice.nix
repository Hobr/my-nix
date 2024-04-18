{ pkgs, ... }: {
  # Dunst
  services.dunst = {
    enable = true;
    catppuccin.enable = true;
    iconTheme = {
      package = pkgs.catppuccin-papirus-folders;
      name = "Papirus";
    };

    settings = { };
  };
}
