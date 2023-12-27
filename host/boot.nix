{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;

        # 上限
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
  };
}
