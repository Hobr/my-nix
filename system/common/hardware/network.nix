{lib, ...}: {
  networking = {
    useDHCP = lib.mkDefault true;
    # proxy.default = "socks5://127.0.0.1:7891";

    # 防火墙
    firewall.enable = false;

    # NetworkManager
    networkmanager = {
      enable = true;
      # 无线网络
      wifi = {
        # 使用设备MAC
        macAddress = "permanent";
        # 查找WIFI时随机MAC
        scanRandMacAddress = true;
      };
    };
  };
}
