{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        # 次代上限
        configurationLimit = 10;
        # 禁用编辑器
        editor = false;
      };
      efi.canTouchEfiVariables = true;
    };
  };
}
