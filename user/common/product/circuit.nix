{ pkgs, ... }: {
  home.packages = with pkgs; [
    ripes
    klayout

    arduino
    arduino-ide
  ];
}
