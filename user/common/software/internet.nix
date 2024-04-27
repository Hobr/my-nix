{ pkgs, ... }: {
  programs.firefox = {
    enable = true;

    # https://mozilla.github.io/policy-templates/
    policies = {
      DisablePocket = true;
      FirefoxHome.Pocket = false;
    };
  };

  home.sessionVariables.BROWSER = "firefox";

  home.packages = with pkgs;
    [
      # 密码管理器
      bitwarden
    ];
}
