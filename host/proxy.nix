{ pkgs, ... }:
{
  programs.proxychains = {
    enable = true;
    # 安静模式
    quietMode = true;

    # 代理
    proxies = {
      myclash = {
        enable = true;
        type = "socks5";
        host = "127.0.0.1";
        port = 7891;
      };
    };
  };

  # Clash
  environment.systemPackages = [
    pkgs.unstable.clash-meta
  ];
}
