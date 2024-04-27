{ pkgs, ... }: {
  home.packages = with pkgs; [
    vscode
    nano
    nixfmt
    nixpkgs-review

    gnome.ghex
    klayout

    arduino
    arduino-ide
  ];
}
