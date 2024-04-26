{ pkgs, ... }: {
  home.packages = with pkgs; [
    # 火狐浏览器
    firefox

    # 密码管理器
    bitwarden
  ];
  home.sessionVariables.BROWSER = "firefox";
}
