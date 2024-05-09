{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    inputs.nix-xilinx.packages.${pkgs.system}.vivado
    ripes
    klayout

    circt
    verilog
    gtkwave

    arduino
    arduino-ide
  ];
}
