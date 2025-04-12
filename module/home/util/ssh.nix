{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.util.ssh;
in
{
  options.home = {
    util.ssh.enable = mkEnableOption "ssh";
    proxy.enable = mkEnableOption "proxy";
  };

  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      matchBlocks = mkIf config.home.proxy.enable {
        "github.com" = {
          hostname = "ssh.github.com";
          user = "git";
          port = 443;
          proxyCommand = "${pkgs.netcat}/bin/nc -v -x 127.0.0.1:7891 %h %p";
        };
      };
    };

    services.ssh-agent.enable = true;
  };
}
