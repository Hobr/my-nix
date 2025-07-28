{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.dev.nix;
in
{
  options.home.dev.nix.enable = mkEnableOption "nix";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nixfmt-rfc-style
      nixpkgs-review
    ];
  };
}
