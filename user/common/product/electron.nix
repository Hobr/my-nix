{ pkgs, ... }: {
  home.packages = with pkgs; [
    ripes
    klayout

    circt
    verilog
    gtkwave

    arduino
    arduino-ide
  ];
}
