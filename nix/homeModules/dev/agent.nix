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
    programs.codexDesktopLinux.enable = true;

    programs.pi-coding-agent = {
      enable = true;
      package = pkgs.llm-agents.pi;
      settings = {
        "theme" = "light";

        "defaultProvider" = "zian";
        "defaultModel" = "gpt-6-luna";
        "defaultThinkingLevel" = "high";

        "httpProxy" = "http://127.0.0.1:7891";

        "defaultTools" = [
          "+codemode"
        ];

        "packages" = [
          "npm:pi-web-access"
          "npm:pi-lens"
          "npm:@ff-labs/pi-fff"
          "npm:@mrclrchtr/supi-claude-md"
          "npm:pi-workspace-history"
          "npm:pi-context-view"
          "npm:pi-provider-newapi"
          "npm:pi-effort"
          "npm:pi-subagents"
        ];
      };
    };

    home.packages = with pkgs.llm-agents; [
      codex
      opencode
      codegraph
      trellis
      spec-kit
    ];
  };
}
