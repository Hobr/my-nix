{
  programs.git = {
    enable = true;

    # 用户
    userName = "Hobr";
    userEmail = "mail@hobr.site";

    # 配置
    extraConfig = {
      safe.directory = "*";
    };

    # LFS
    lfs.enable = true;
    # Delta
    delta.enable = true;
  };
}
