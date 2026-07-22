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
  cfg = config.home.dev.agent;
in
{
  options.home.dev.agent.enable = mkEnableOption "agent";

  config = mkIf cfg.enable {
    programs.codexDesktopLinux = {
      enable = true;
      cliPackage = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.codex;
    };

    home.packages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
      claude-code
      codex
      pi
      opencode
      codegraph
      trellis
    ];
  };
}
