{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.sys.boot.secure-boot;
in
{
  options.sys.boot.secure-boot.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ sbctl ];

    boot.loader.systemd-boot.enable = mkForce false;
    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };
}
