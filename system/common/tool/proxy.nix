{ pkgs, lib, ... }:
{
  programs.proxychains = {
    enable = true;
    package = pkgs.unstable.proxychains-ng;
    quietMode = true;

    # 代理
    proxies = {
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
        port = 7890;
      };
    };
  };

  # Clash
  environment.systemPackages = lib.mkAfter [ pkgs.unstable.clash-verge-rev ];
}
