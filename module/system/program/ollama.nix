{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.sys.program.ollama;
in
{
  options.sys.program.ollama.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    services.ollama = {
      enable = true;
      openFirewall = true;
    };

    services.nextjs-ollama-llm-ui.enable = true;
  };
}
