{
  config,
  options,
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
    programs.codexDesktopLinux = {
      enable = true;
      computerUseUi.enable = true;
      linuxFeatures = [
        "api-key-model-visibility"
        "api-key-service-tier"
        "mcp-helper-reaper"
        "node-repl-reaper"
      ];
    };

    programs.pi-coding-agent = {
      enable = true;
      package = pkgs.llm-agents.pi;
      extraPackages = with pkgs; [
        nodejs
        bun
      ];
    };

    home.packages = with pkgs.llm-agents; [
      claude-code
      codex
      opencode
      codegraph
      spec-kit
      trellis
    ];
  };
}
