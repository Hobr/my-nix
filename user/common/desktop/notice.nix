{ pkgs, ... }: {
  # Dunst
  services.dunst = {
    enable = true;
    package = pkgs.unstable.dunst;
    iconTheme = {
      package = pkgs.unstable.catppuccin-papirus-folders;
      name = "Papirus";
    };

    settings = { };
  };
}
