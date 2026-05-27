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
      enableDefaultConfig = false;

      settings = {
        "github.com" = mkIf config.home.proxy.enable {
          HostName = "ssh.github.com";
          User = "git";
          Port = 443;
          ProxyCommand = "${pkgs.netcat}/bin/nc -v -x 127.0.0.1:7891 %h %p";
        };

        "kanade" = {
          HostName = "10.1.127.2";
          User = "kanade";
          Port = 22;
        };
      };
    };

    services.ssh-agent.enable = true;
  };
}
