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

    wallpaper = {
      preload = mkOption {
        type = with types; listOf str;
        default = [ ];
      };
      monitor = mkOption {
        type = with types; listOf str;
        default = [ ];
      };
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = pkgs.small.hyprland;
      xwayland.enable = true;

      # 设置
      settings = {
        monitor = cfg.monitor;

        env =
          [
            # Cursor
            "HYPRCURSOR_THEME,rose-pine-hyprcursor"
            "HYPRCURSOR_SIZE,24"

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
          "telegram-desktop -startintray"
          "clash-verge"
          "${pkgs.hyprdim}/bin/hyprdim"
          "${pkgs.hyprsunset}/bin/hyprsunset"
        ];

        general = {
          # 窗口边框大小
          border_size = 2;
          # 取消浮动窗口边框
          no_border_on_floating = true;
          # 窗口间间隙
          gaps_in = 5;
          # 窗口与屏幕边框间隔
          gaps_out = 20;
          # 布局
          layout = "dwindle";
        };
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        decoration = {
          # 圆角半径
          rounding = 10;
          # 活动窗口不透明度
          active_opacity = 1.0;
          # 不活动窗口不透明度
          inactive_opacity = 1.0;
          # 全屏窗口不透明度
          fullscreen_opacity = 1.0;

          # 模糊
          blur = {
            # 启用
            enabled = true;
            # 大小
            size = 3;
            # 模糊程度
            passes = 1;
            # 优化
            new_optimizations = true;
            # 模糊菜单
            popups = true;
          };
        };

        input = {
          # 键盘布局
          kb_layout = "us";
          # 光标跟随鼠标状态
          follow_mouse = 1;
          # 灵敏度
          sensitivity = 0;
          # 反向滚动
          touchpad.natural_scroll = false;
          # 与屏幕旋转值一样
          touchdevice.transform = 0;
          tablet.transform = 0;
        };

        gestures = {
          # 触控屏空间切换
          workspace_swipe_touch = true;
          # 触控板空间切换
          workspace_swipe = true;
          # 切换用指数
          workspace_swipe_fingers = 3;
        };

        misc = {
          # 禁用随机背景
          disable_hyprland_logo = true;
          # 鼠标拖动窗口动画
          animate_mouse_windowdragging = true;
          # 聚焦于请求聚焦的端口
          focus_on_activate = true;
        };

        opengl = {
          # 停用强制introspection
          force_introspection = 0;
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
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = cfg.wallpaper.preload;
        wallpaper = cfg.wallpaper.monitor;
      };
    };
  };
}
