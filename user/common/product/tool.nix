{ pkgs, ... }: {
  home.packages = with pkgs; [
    nano
    nixfmt
    nixpkgs-review

    gnome.ghex
    klayout

    arduino
    arduino-ide
  ];
}
