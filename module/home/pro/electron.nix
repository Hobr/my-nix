{
  config,
  options,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  cfg = config.home.pro.electron;
in
{
  options.home.pro.electron.enable = mkEnableOption "electron";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # 电路设计
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
  };
}
