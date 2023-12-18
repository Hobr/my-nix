{
  networking = {
    hostName = "umipro";
    nameservers = [ "8.8.8.8" "1.1.1.1" ];

    networkmanager = {
      enable = true;
      unmanaged = [ "docker0" "rndis0" ];
      wifi = {
        macAddress = "random";
        powersave = true;
      };
    };

    firewall = {
      enable = true;
      allowPing = false;
      logReversePathDrops = true;
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;
}
