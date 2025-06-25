{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.home.dev.git;
in
{
  options.home.dev.git.enable = mkEnableOption "git";

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;

      # 用户
      userName = "Hobr";
      userEmail = "mail@hobr.site";

      # 签名
      signing = {
        format = "openpgp";
        key = "0FD726E34F50F5B0";
        signByDefault = true;
      };

      # 配置
      extraConfig = {
        # 默认分支名
        init.defaultBranch = "main";

        # 信任所有目录
        safe.directory = "*";

        # 代理
        http.proxy = mkIf config.home.proxy.enable "http://127.0.0.1:7891";
        https.proxy = mkIf config.home.proxy.enable "http://127.0.0.1:7891";

        core.editor = "nvim";
        pull.rebase = true;
        branch.autosetuprebase = "always";
      };

      # LFS
      lfs.enable = true;
      # Diff
      diff-so-fancy.enable = true;
      # 忽略
      ignores = [
        ".direnv"
        ".venv"
        ".cargo"
        "result*"
        "venv"
      ];
    };

    # LazyGit
    programs.lazygit = {
      enable = true;
      settings = {
        git.overrideGpg = true;
      };
    };
  };
}
