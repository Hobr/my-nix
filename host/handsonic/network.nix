{ lib, ... }:
{
  networking = {
    hostName = "handsonic";
    useDHCP = true;

    # NetworkManager
    networkmanager = {
      enable = true;
      wifi = {
        macAddress = "random";
        powersave = true;
      };
    };

    services.resolved = {
      enable = true;
      # DNSSEC
      dnssec = "allow-downgrade";
      # 后备DNS
      fallbackDns = [ "8.8.8.8" "8.8.4.4" ];

      extraConfig = ''
        DNSOverTLS=yes
      '';
    };

    users.users.kanade.extraGroups = lib.mkAfter [ "networkmanager" ];
  }
