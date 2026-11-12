{
  config,
  options,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.dev.agent;
in
{
  options.home.dev.agent.enable = mkEnableOption "agent";

  config = mkIf cfg.enable {
    programs.pi-coding-agent = {
      enable = true;
      package = pkgs.inputs'.llm-agents.packages.pi;
    };

    home.packages = with pkgs.inputs'.llm-agents.packages; [
      codex
      codegraph
    ];
  };
}
