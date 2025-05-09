{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.sys.io.network;
in
{
  options.sys.io.network.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    # DNS服务
    services.resolved = {
      enable = true;
      # DNSSEC
      dnssec = "allow-downgrade";
      # 后备DNS
      fallbackDns = [
        "8.8.8.8"
        "1.1.1.1"
      ];
    };

    networking = {
      useDHCP = mkDefault true;
      proxy.default = mkIf config.sys.program.proxy.enable "http://127.0.0.1:7891";

      # 防火墙
      firewall.enable = false;

      # NetworkManager
      networkmanager = {
        enable = true;
        # DNS服务
        dns = "systemd-resolved";

        # 无线网络
        wifi = {
          # 使用设备MAC
          macAddress = "permanent";
          # 查找WIFI时随机MAC
          scanRandMacAddress = true;
        };
      };
    };
  };
}
