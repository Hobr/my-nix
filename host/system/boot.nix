{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        # 禁止编辑启动项
        editor = false;
        # 上限
        configurationLimit = 15;
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
  };

  boot.plymouth = {
    enable = true;
  };
  boot.initrd.systemd.enable = true;
}
