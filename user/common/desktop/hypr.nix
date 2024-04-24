{ pkgs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
    catppuccin.enable = true;

    # 设置
    settings = {
      env = [
        # 鼠标大小
        "XCURSOR_SIZE,24"

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
      ];

      exec-once = [
        # 粘贴板
        "cliphist wipe"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
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
        # 活动窗口边框颜色
        #"col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        # 非活动窗口边框颜色
        #"col.inactive_border" = "rgba(595959aa)";
        # 光标不使用多少秒后消失
        cursor_inactive_timeout = 5;
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
        # 窗口投影
        drop_shadow = true;
        # 投影大小
        shadow_range = 4;
        # 阴影渐变程度
        shadow_render_power = 3;
        # 不在窗口后渲染
        shadow_ignore_window = true;
        # 阴影颜色
        #"col.shadow" = "rgba(1a1a1aee)";

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

      windowrulev2 =
        [ "float,class:^(pavucontrol)$" "float,class:^(blueman-manager)$" ];

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

    # 插件
    plugins = [ ];
  };

  # 壁纸
  services.hyprpaper.enable = true;

  # IDLE
  services.hypridle = {
    enable = true;
    # 检查线程, 避免多开
    lockCmd = "pidof swaylock || swaylock";
    # 挂起
    beforeSleepCmd = "systemctl suspend";
    # 点击唤醒
    afterSleepCmd = "hyprctl dispatch dpms on";

    listeners = [
      # 降低亮度
      {
        # 1.5分钟
        timeout = 150;
        # 设置为最低亮度
        onTimeout = "brightnessctl set 20%";
        # 苏醒 恢复亮度
        onResume = "brightnessctl -r";
      }
      # 锁定
      {
        # 5分钟
        timeout = 300;
        # 锁屏
        onTimeout = "swaylock";
      }
      # 关闭屏幕
      {
        # 5.5分钟
        timeout = 330;
        # 熄屏
        onTimeout = "hyprctl dispatch dpms off";
        # 恢复
        onResume = "hyprctl dispatch dpms on";
      }
      # 挂起
      {
        # 10分钟
        timeout = 600;
        # 挂起
        onTimeout = "systemctl suspend";
      }
    ];
  };
}
