{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.sys.program.ld;
in
{
  options.sys.program.ld.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    programs.nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
    };
  };
}
