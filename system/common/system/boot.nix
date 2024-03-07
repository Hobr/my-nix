{
  # Bootloader
  boot.loader = {
    systemd-boot = {
      enable = false;
      editor = false;
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  # Splash
  boot.plymouth = {
    enable = true;
  };
  boot.initrd.systemd.enable = true;
}
