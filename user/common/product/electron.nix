{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    inputs.nix-xilinx.packages.${pkgs.system}.vivado
    ripes
    klayout

    verilog
    verilator
    gtkwave
    circt

    arduino
    arduino-ide
  ];
}