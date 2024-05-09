{ pkgs, ... }: {
  home.packages = with pkgs; [
    nano
    nurl
    nix-init
    nixfmt-rfc-style
    nixpkgs-review

    pre-commit
    gnome.ghex
  ];
}
