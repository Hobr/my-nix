{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.home.desktop.hypr;
in
{
  options.home.desktop.hypr = {
    enable = mkEnableOption "enable";
    nvidia = mkEnableOption "nvidia";

    monitor = mkOption {
      type = with types; listOf str;
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd.enableXdgAutostart = true;

      # 设置
      settings = {
        monitor = cfg.monitor;

        env = [
          # QT
          "QT_QPA_PLATFORM,wayland;xcb"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "QT_AUTO_SCREEN_SCALE_FACTOR,1"

          # Wayland
          "NIXOS_OZONE_WL,1"
          "GDK_BACKEND,wayland,x11"
          "XDG_SESSION_TYPE,wayland"
          "SDL_VIDEODRIVER,wayland"
          "MOZ_ENABLE_WAYLAND,1"
        ]
        # NVIDIA
        ++ optionals cfg.nvidia [
          "GBM_BACKEND,nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "LIBVA_DRIVER_NAME,nvidia"
          "NVD_BACKEND,direct"
          "MOZ_X11_EGL,1"
          "MOZ_DISABLE_RDD_SANDBOX,1"
          "WLR_NO_HARDWARE_CURSORS,1"
          "ELECTRON_OZONE_PLATFORM_HINT,auto"
        ];

        exec-once = [
          # 粘贴板
          "cliphist wipe"
          "wl-paste --type text --watch cliphist store"
          "wl-paste --type image --watch cliphist store"

          # 开机启动
          "Telegram -startintray"
          "clash-verge"
        ];

        general = {
          # 窗口边框大小
          border_size = 2;
          # 不显示浮动窗口边框
          no_border_on_floating = true;
          # 窗口间间隙
          gaps_in = 5;
          # 窗口与屏幕边框间隔
          gaps_out = 15;
          # 布局
          layout = "dwindle";
          # 单击调整窗口大小
          resize_on_border = true;
        };

        # 二叉树布局
        dwindle = {
          # 伪平铺
          pseudotile = true;
          # 保持分割
          preserve_split = true;
          # 精确分割
          smart_split = false;
        };

        decoration = {
          # 圆角半径
          rounding = 15;
          # 活动窗口不透明度
          active_opacity = 1;
          # 不活动窗口不透明度
          inactive_opacity = 1;
          # 全屏窗口不透明度
          fullscreen_opacity = 1.0;

          # 模糊
          blur = {
            # 启用
            enabled = true;
            # 大小
            size = 25;
            # 模糊程度
            passes = 1;
            # 优化
            new_optimizations = true;
            # 模糊菜单
            popups = true;
          };

          # 阴影
          shadow = {
            # 启用
            enabled = true;
            # 范围
            range = 2;
            # 清晰
            sharp = true;
          };
        };

        # 触控
        gestures = {
          workspace_swipe_touch = true;
          gesture = [ "3, horizontal, workspace" ];
        };

        # 杂项
        misc = {
          # 禁用随机背景
          disable_hyprland_logo = true;
          # 禁用启动画面渲染
          disable_splash_rendering = true;
          # 聚焦于请求聚焦的端口
          focus_on_activate = true;
        };

        # OpenGL
        opengl = {
          # 减少NVIDIA闪烁
          nvidia_anti_flicker = true;
        };

        # 生态
        ecosystem = {
          # 禁用更新新闻
          no_update_news = true;
          # 禁用捐赠提示
          no_donation_nag = true;
        };

        animations = {
          enabled = "yes";
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        windowrulev2 = [
          "float,class:^(pavucontrol)$"
          "float,class:^(blueman-manager)$"
          "fullscreen,title:^(Ani)$"
        ];

        "$mainMod" = "SUPER";

        bind = [
          # 软件
          "$mainMod, Q, exec, kitty"
          "$mainMod, A, exec, firefox"
          "$mainMod, E, exec, code"
          "$mainMod, W, exec, rofi -show drun"
          "$mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"

          # 窗口
          "$mainMod, X, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, F, togglefloating,"

          # Dwindle
          "$mainMod, P, pseudo,"
          "$mainMod, J, togglesplit,"

          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"

          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"

          "$mainMod, mouse_up, workspace, e+1"
          "$mainMod, mouse_down, workspace, e-1"

          # Pipewire
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-"

          # Brightness
          ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
          ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"

          # Playerctl
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86audiostop, exec, playerctl stop"
        ];

        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
      };
    };

    # 壁纸
    services.hyprpaper.enable = true;
  };
}
