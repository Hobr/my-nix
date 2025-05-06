{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.sys.program.proxy;
in
{
  options.sys.program.proxy.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    programs.clash-verge = {
      enable = true;
      package = pkgs.clash-verge-rev;
      autoStart = true;
    };

    environment.systemPackages = with pkgs; [
      mihomo
    ];

    programs.proxychains = {
      enable = true;
      package = pkgs.proxychains-ng;
      quietMode = true;

      # 代理
      proxies = mkIf config.sys.program.proxy.enable {
        sock = {
          enable = true;
          type = "socks5";
          host = "127.0.0.1";
          port = 7891;
        };
        http = {
          enable = true;
          type = "http";
          host = "127.0.0.1";
          port = 7891;
        };
      };
    };
  };
}
