{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.util.zellij;
in
{
  options.home.util.zellij.enable = mkEnableOption "zellij";

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      enableZshIntegration = true;
      exitShellOnExit = true;

      settings = {
        # 主题
        theme = "catppuccin-macchiato";
        # 简化UI
        simplified_ui = false;

        # 自动布局调整
        auto_layout = true;
        # 显示窗格边框
        pane_frames = false;
        # 启用视觉提示
        visual_bell = true;
        # 启用样式化下划线
        styled_underlines = true;

        # 启动时Tip
        show_startup_tips = false;
        # 默认模式
        default_mode = "locked";
        # 默认shell
        default_shell = "zsh";
        # Kitty键盘协议
        support_kitty_keyboard_protocol = true;

        # 收到关闭信号时
        on_force_close = "quit";
        # 选中复制
        copy_on_select = true;
        # 复制命令
        copy_command = "wl-copy";

        # 启用鼠标
        mouse_mode = true;
        # 鼠标悬停效果
        mouse_hover_effects = true;
        # 鼠标跟随焦点
        focus_follows_mouse = false;
      };
    };

    stylix.targets.zellij.enable = false;
  };
}
