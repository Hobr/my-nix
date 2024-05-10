{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    inputs.nix-xilinx.packages.${pkgs.system}.vivado
    ripes
    klayout

    verilog
    gtkwave

    arduino
    arduino-ide
  ];
}
