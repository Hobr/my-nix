{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.boot.secure-boot;
in
{
  options.boot.secure-boot.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [ sbctl ];

    boot.loader.systemd-boot.enable = lib.mkForce false;
    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };
}
