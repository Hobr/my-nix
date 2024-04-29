{ pkgs, ... }: {
  home.packages = with pkgs; [
    nano
    nixfmt
    nixpkgs-review
    pre-commit

    gnome.ghex
  ];
}
