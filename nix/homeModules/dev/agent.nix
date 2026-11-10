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
      package = pkgs.llm-agents.pi;
    };

    home.packages = with pkgs.llm-agents; [
      codex
      opencode2
      codegraph
      trellis
      spec-kit
      openspec
    ];
  };
}
