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
  }
