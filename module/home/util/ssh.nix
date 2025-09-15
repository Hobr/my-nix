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

      matchBlocks = {
        "github.com" = mkIf config.home.proxy.enable {
          hostname = "ssh.github.com";
          user = "git";
          port = 443;
          proxyCommand = "${pkgs.netcat}/bin/nc -v -x 127.0.0.1:7891 %h %p";
        };

        "kanade" = {
          hostname = "10.1.127.2";
          user = "kanade";
          port = 443;
        };

        "yuri" = {
          hostname = "10.1.127.3";
          user = "yuri";
          port = 443;
        };

        "yuzuru" = {
          hostname = "10.1.127.4";
          user = "yuzuru";
          port = 443;
        };
      };
    };

    services.ssh-agent.enable = true;
  };
}
