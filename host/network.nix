{ lib, ... }:
{
  # DNS服务
  services.resolved = {
    enable = true;
  };

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
      # 无线网络
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
  users.users.kanade.extraGroups = lib.mkAfter [ "networkmanager" ];
}
