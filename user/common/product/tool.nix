{ pkgs, ... }: {
  home.packages = with pkgs; [
    vscode
    nano
    nixfmt
    nixpkgs-review

    gnome.ghex
    charles
    klayout

    arduino
    arduino-ide
  ];
}
