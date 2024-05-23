{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;

    plugins.lightline.enable = true;

    opts = {
      number = true; # Show line numbers
      relativenumber = true; # Show relative line numbers
      shiftwidth = 2; # Tab width should be 2
    };

    keymaps = [
      {
        key = ";";
        action = ":";
      }
      {
        mode = "n";
        key = "<leader>m";
        options.silent = true;
        action = "<cmd>!make<CR>";
      }
    ];
  };

  # NeoVide
  home.packages = with pkgs; [ neovide ];
}
