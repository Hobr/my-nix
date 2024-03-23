{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    package = pkgs.unstable.kitty;
    shellIntegration.enableZshIntegration = true;

    # 配置
    theme = "Catppuccin-Latte";
    font = {
      name = "Mononoki Nerd Font";
      size = 12;
    };
  };
}
