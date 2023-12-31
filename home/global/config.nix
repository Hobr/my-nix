{
  home = {
    username = "kanade";
    homeDirectory = "/home/kanade";
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;

  home = {
    # $PATH
    sessionPath = [ ];
    # 环境变量
    sessionVariables = { };
    # 别名
    shellAliases = { };
  };
}
