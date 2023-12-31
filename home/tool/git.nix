{
  programs.git = {
    enable = true;

    # 用户
    userName = "Hobr";
    userEmail = "mail@hobr.site";

    # 签名
    signing = {
      key = "0FD726E34F50F5B0";
      signByDefault = true;
    };

    # 配置
    extraConfig = {
      # 默认分支名
      init.defaultBranch = "main";

      # 信任所有目录
      safe.directory = "*";
    };

    # LFS
    lfs.enable = true;
    # Delta
    delta.enable = true;
  };
}
