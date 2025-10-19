{
  config,
  options,
  lib,
  pkgs,
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

      # 签名
      signing = {
        format = "openpgp";
        key = "0FD726E34F50F5B0";
        signByDefault = true;
      };

      # 配置
      settings = {
        # 用户信息
        user = {
          name = "Hobr";
          email = "mail@hobr.site";
        };

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

      # 忽略
      ignores = [
        ".direnv"
        ".venv"
        ".cargo"
        "result*"
        "venv"
      ];
    };

    # Diff
    programs.diff-so-fancy = {
      enable = true;
      enableGitIntegration = true;
    };

    # LazyGit
    programs.lazygit = {
      enable = true;
      settings = {
        git.overrideGpg = true;
      };
    };

    home.packages = with pkgs; [
      gh
    ];
  };
}
