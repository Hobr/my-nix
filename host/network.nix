{lib,...}:
{
  networking = {
    hostName = "handsonic";
    useDHCP = lib.mkDefault true;

    # 防火墙
    firewall.enable = false;

    # NetworkManager
    networkmanager = {
      enable = true;

      # DNS服务
      dns = "systemd-resolved";

      wifi = {
        # 使用设备MAC
        macAddress = "permanent";
        # 查找WIFI时随机MAC
        scanRandMacAddress = true;
        # 省电模式
        powersave = true;
      };
    };
  };

  # 用户组
  users.users.kanade.extraGroups = lib.mkAfter ["networkmanager"];
}