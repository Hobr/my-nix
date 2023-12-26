{lib,...}:
{
  security.sudo = {
    enable = true;

    # Wheel组无需密码
    wheelNeedsPassword = true;
  };

  # 用户组
  users.users.kanade.extraGroups = lib.mkAfter ["wheel"];

  security.rtkit.enable = true;
}
