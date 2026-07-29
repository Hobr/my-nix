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

  toLua = generators.toLua { };
  luaInline = generators.mkLuaInline;

  mkEnv = name: value: {
    _args = [
      name
      value
    ];
  };

  mkBind = keys: dispatcher: bindOptions: {
    _args = [
      keys
      (luaInline dispatcher)
    ]
    ++ optional (bindOptions != null) bindOptions;
  };

  mkExecBind = keys: command: mkBind keys "hl.dsp.exec_cmd(${toLua command})" null;
  mkModKey = key: luaInline ''mainMod .. " + ${key}"'';

  workspaceBinds = concatMap (
    workspace:
    let
      number = toString workspace;
    in
    [
      (mkBind (mkModKey number) ''hl.dsp.focus({ workspace = "${number}" })'' null)
      (mkBind (mkModKey "SHIFT + ${number}") ''hl.dsp.window.move({ workspace = "${number}" })'' null)
    ]
  ) (range 1 9);
in
{
  options.home.desktop.hypr = {
    enable = mkEnableOption "enable";
    nvidia = mkEnableOption "nvidia";

    monitor = mkOption {
      type =
        with types;
        listOf (submodule {
          options = {
            output = mkOption {
              type = str;
              description = "Monitor output name.";
            };
            mode = mkOption {
              type = str;
              default = "preferred";
              description = "Monitor mode.";
            };
            position = mkOption {
              type = str;
              default = "auto";
              description = "Monitor position.";
            };
            scale = mkOption {
              type = oneOf [
                int
                float
                str
              ];
              default = "auto";
              description = "Monitor scale.";
            };
          };
        });
      default = [ ];
      description = "Hyprland monitor definitions.";
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enableXdgAutostart = true;
      configType = "lua";

      settings = {
        monitor = cfg.monitor;

        env = [
          # QT
          (mkEnv "QT_QPA_PLATFORM" "wayland;xcb")
          (mkEnv "QT_WAYLAND_DISABLE_WINDOWDECORATION" "1")
          (mkEnv "QT_AUTO_SCREEN_SCALE_FACTOR" "1")

          # Wayland
          (mkEnv "NIXOS_OZONE_WL" "1")
          (mkEnv "GDK_BACKEND" "wayland,x11")
          (mkEnv "XDG_SESSION_TYPE" "wayland")
          (mkEnv "SDL_VIDEODRIVER" "wayland")
          (mkEnv "MOZ_ENABLE_WAYLAND" "1")

          # Clash Verge
          (mkEnv "WEBKIT_DISABLE_DMABUF_RENDERER" "1")
        ]
        # NVIDIA
        ++ optionals cfg.nvidia [
          (mkEnv "GBM_BACKEND" "nvidia-drm")
          (mkEnv "__GLX_VENDOR_LIBRARY_NAME" "nvidia")
          (mkEnv "LIBVA_DRIVER_NAME" "nvidia")
          (mkEnv "NVD_BACKEND" "direct")
          (mkEnv "MOZ_X11_EGL" "1")
          (mkEnv "MOZ_DISABLE_RDD_SANDBOX" "1")
          (mkEnv "WLR_NO_HARDWARE_CURSORS" "1")
          (mkEnv "ELECTRON_OZONE_PLATFORM_HINT" "auto")
        ];

        on = {
          _args = [
            "hyprland.start"
            (luaInline ''
              function()
                hl.exec_cmd("cliphist wipe")
                hl.exec_cmd("wl-paste --type text --watch cliphist store")
                hl.exec_cmd("wl-paste --type image --watch cliphist store")
                hl.exec_cmd("Telegram -startintray")
                hl.exec_cmd("clash-verge")
              end
            '')
          ];
        };

        config = {
          general = {
            # 窗口边框大小
            border_size = 2;
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
          gestures.workspace_swipe_touch = true;

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

          animations.enabled = true;
        };

        curve = {
          _args = [
            "myBezier"
            {
              type = "bezier";
              points = [
                [
                  0.05
                  0.9
                ]
                [
                  0.1
                  1.05
                ]
              ];
            }
          ];
        };

        animation = [
          {
            leaf = "windows";
            enabled = true;
            speed = 7;
            bezier = "myBezier";
          }
          {
            leaf = "windowsOut";
            enabled = true;
            speed = 7;
            bezier = "default";
            style = "popin 80%";
          }
          {
            leaf = "border";
            enabled = true;
            speed = 10;
            bezier = "default";
          }
          {
            leaf = "borderangle";
            enabled = true;
            speed = 8;
            bezier = "default";
          }
          {
            leaf = "fade";
            enabled = true;
            speed = 7;
            bezier = "default";
          }
          {
            leaf = "workspaces";
            enabled = true;
            speed = 6;
            bezier = "default";
          }
        ];

        gesture = {
          fingers = 3;
          direction = "horizontal";
          action = "workspace";
        };

        mainMod = {
          _var = "SUPER";
        };

        bind = [
          # 软件
          (mkExecBind (mkModKey "Q") "kitty")
          (mkExecBind (mkModKey "A") "firefox")
          (mkExecBind (mkModKey "E") "code")
          (mkExecBind (mkModKey "W") "rofi -show drun")
          (mkExecBind (mkModKey "V") "cliphist list | rofi -dmenu | cliphist decode | wl-copy")

          # 窗口
          (mkBind (mkModKey "X") "hl.dsp.window.close()" null)
          (mkBind (mkModKey "M") "hl.dsp.exit()" null)
          (mkBind (mkModKey "F") ''hl.dsp.window.float({ action = "toggle" })'' null)

          (mkBind (mkModKey "left") ''hl.dsp.focus({ direction = "left" })'' null)
          (mkBind (mkModKey "right") ''hl.dsp.focus({ direction = "right" })'' null)
          (mkBind (mkModKey "up") ''hl.dsp.focus({ direction = "up" })'' null)
          (mkBind (mkModKey "down") ''hl.dsp.focus({ direction = "down" })'' null)

        ]
        ++ workspaceBinds
        ++ [
          (mkBind (mkModKey "mouse_down") ''hl.dsp.focus({ workspace = "e+1" })'' null)
          (mkBind (mkModKey "mouse_up") ''hl.dsp.focus({ workspace = "e-1" })'' null)

          # Pipewire
          (mkExecBind "XF86AudioRaiseVolume" "wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%+")
          (mkExecBind "XF86AudioLowerVolume" "wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-")

          # Brightness
          (mkExecBind "XF86MonBrightnessDown" "brightnessctl set 5%-")
          (mkExecBind "XF86MonBrightnessUp" "brightnessctl set 5%+")

          # Playerctl
          (mkExecBind "XF86AudioPlay" "playerctl play-pause")
          (mkExecBind "XF86AudioNext" "playerctl next")
          (mkExecBind "XF86AudioPrev" "playerctl previous")
          (mkExecBind "XF86AudioStop" "playerctl stop")

          # 鼠标
          (mkBind (mkModKey "mouse:272") "hl.dsp.window.drag()" { mouse = true; })
          (mkBind (mkModKey "mouse:273") "hl.dsp.window.resize()" { mouse = true; })
        ];
      };
    };

    # 壁纸
    services.hyprpaper.enable = true;

    # Polkit
    services.hyprpolkitagent.enable = true;

    # 截图
    programs.hyprshot.enable = true;
  };
}
