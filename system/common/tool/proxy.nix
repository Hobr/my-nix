{ pkgs, ... }:
{
  programs.clash-verge = {
    enable = true;
    package = pkgs.clash-verge-rev;
    tunMode = true;
    autoStart = true;
  };

  programs.proxychains = {
    enable = true;
    package = pkgs.proxychains-ng;
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
        port = 7891;
      };
    };
  };
}
