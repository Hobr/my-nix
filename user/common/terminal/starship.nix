{inputs, ...}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings =
      {
        format = "$all";
        palette = "catppuccin_latte";
      }
      // builtins.fromTOML (builtins.readFile "${inputs.catppuccin-starship}/palettes/latte.toml");
  };
}
