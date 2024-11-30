{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    # 电路设计
    stable.kicad-small
    stable.kikit
    librepcb
    klayout
    circt
    # 仿真
    yosys
    inputs.nix-xilinx.packages.${pkgs.system}.vivado
    qucs-s
    # 模拟器
    ripes
    qtrvsim
    # Verilog
    verilog
    verilator
    verible
    # 波形
    gtkwave
  ];
}
