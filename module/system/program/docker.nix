{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.sys.program.docker;
in
{
  options.sys.program.docker.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = true;
      autoPrune.enable = true;
      storageDriver = "btrfs";
      daemon.settings = {
        experimental = true;
        live-restore = true;
        registry-mirrors = [ "https://docker.m.daocloud.io" ];
      };
    };

    environment.systemPackages = with pkgs; [
      compose2nix
    ];
  };
}
