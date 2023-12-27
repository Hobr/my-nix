{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        # 禁止编辑启动项
        editor = false;
        # 上限
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
  };
}
