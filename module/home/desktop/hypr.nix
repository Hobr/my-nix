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

  mkExecBindWith =
    keys: command: bindOptions:
    mkBind keys "hl.dsp.exec_cmd(${toLua command})" bindOptions;
  mkExecBind = keys: command: mkExecBindWith keys command null;
  mkModKey = key: luaInline ''mainMod .. " + ${key}"'';

  workspaceBinds = concatMap (
    workspace:
    let
      key = if workspace == 10 then "0" else toString workspace;
      number = toString workspace;
    in
    [
      (mkBind (mkModKey key) ''hl.dsp.focus({ workspace = "${number}" })'' null)
      (mkBind (mkModKey "SHIFT + ${key}") ''hl.dsp.window.move({ workspace = "${number}" })'' null)
    ]
  ) (range 1 10);
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
        monitor = cfg.monitor ++ [
          {
            output = "";
            mode = "preferred";
            position = "auto";
            scale = "auto";
          }
        ];

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
          (mkEnv "__GLX_VENDOR_LIBRARY_NAME" "nvidia")
          (mkEnv "LIBVA_DRIVER_NAME" "nvidia")
          (mkEnv "NVD_BACKEND" "direct")
          (mkEnv "ELECTRON_OZONE_PLATFORM_HINT" "auto")
        ];

        on = {
          _args = [
            "hyprland.start"
            (luaInline ''
              function()
                hl.exec_cmd("Telegram -startintray")
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
            rounding_power = 2;
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
              size = 6;
              # 模糊程度
              passes = 2;
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

          input = {
            follow_mouse = 1;
            sensitivity = 0;

            touchpad = {
              disable_while_typing = true;
              natural_scroll = false;
              scroll_factor = 1.0;
              tap_to_click = true;
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

        curve = [
          {
            _args = [
              "easeOutQuint"
              {
                type = "bezier";
                points = [
                  [
                    0.23
                    1
                  ]
                  [
                    0.32
                    1
                  ]
                ];
              }
            ];
          }
          {
            _args = [
              "linear"
              {
                type = "bezier";
                points = [
                  [
                    0
                    0
                  ]
                  [
                    1
                    1
                  ]
                ];
              }
            ];
          }
          {
            _args = [
              "almostLinear"
              {
                type = "bezier";
                points = [
                  [
                    0.5
                    0.5
                  ]
                  [
                    0.75
                    1
                  ]
                ];
              }
            ];
          }
          {
            _args = [
              "quick"
              {
                type = "bezier";
                points = [
                  [
                    0.15
                    0
                  ]
                  [
                    0.1
                    1
                  ]
                ];
              }
            ];
          }
          {
            _args = [
              "easy"
              {
                type = "spring";
                mass = 1;
                stiffness = 238.1191;
                dampening = 24.21279333;
              }
            ];
          }
        ];

        animation = [
          {
            leaf = "global";
            enabled = true;
            speed = 10;
            bezier = "default";
          }
          {
            leaf = "windows";
            enabled = true;
            speed = 4.79;
            spring = "easy";
          }
          {
            leaf = "windowsIn";
            enabled = true;
            speed = 4.1;
            spring = "easy";
            style = "popin 87%";
          }
          {
            leaf = "windowsOut";
            enabled = true;
            speed = 1.49;
            bezier = "linear";
            style = "popin 87%";
          }
          {
            leaf = "border";
            enabled = true;
            speed = 5.39;
            bezier = "easeOutQuint";
          }
          {
            leaf = "fadeIn";
            enabled = true;
            speed = 1.73;
            bezier = "almostLinear";
          }
          {
            leaf = "fadeOut";
            enabled = true;
            speed = 1.46;
            bezier = "almostLinear";
          }
          {
            leaf = "fade";
            enabled = true;
            speed = 3.03;
            bezier = "quick";
          }
          {
            leaf = "layers";
            enabled = true;
            speed = 3.81;
            bezier = "easeOutQuint";
          }
          {
            leaf = "layersIn";
            enabled = true;
            speed = 4;
            bezier = "easeOutQuint";
            style = "fade";
          }
          {
            leaf = "layersOut";
            enabled = true;
            speed = 1.5;
            bezier = "linear";
            style = "fade";
          }
          {
            leaf = "workspaces";
            enabled = true;
            speed = 1.94;
            bezier = "almostLinear";
            style = "fade";
          }
        ];

        gesture = {
          fingers = 3;
          direction = "horizontal";
          action = "workspace";
        };

        window_rule = {
          name = "fix-xwayland-drags";
          match = {
            class = "^$";
            title = "^$";
            xwayland = true;
            float = true;
            fullscreen = false;
            pin = false;
          };
          no_focus = true;
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
          (mkExecBind (mkModKey "M") "wlogout")
          (mkBind (mkModKey "F") ''hl.dsp.window.float({ action = "toggle" })'' null)

          (mkBind (mkModKey "left") ''hl.dsp.focus({ direction = "left" })'' null)
          (mkBind (mkModKey "right") ''hl.dsp.focus({ direction = "right" })'' null)
          (mkBind (mkModKey "up") ''hl.dsp.focus({ direction = "up" })'' null)
          (mkBind (mkModKey "down") ''hl.dsp.focus({ direction = "down" })'' null)

          # 特殊工作区
          (mkBind (mkModKey "S") ''hl.dsp.workspace.toggle_special("magic")'' null)
          (mkBind (mkModKey "SHIFT + S") ''hl.dsp.window.move({ workspace = "special:magic" })'' null)

        ]
        ++ workspaceBinds
        ++ [
          (mkBind (mkModKey "mouse_down") ''hl.dsp.focus({ workspace = "e+1" })'' null)
          (mkBind (mkModKey "mouse_up") ''hl.dsp.focus({ workspace = "e-1" })'' null)

          # Pipewire
          (mkExecBindWith "XF86AudioRaiseVolume" "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 3%+" {
            locked = true;
            repeating = true;
          })
          (mkExecBindWith "XF86AudioLowerVolume" "wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-" {
            locked = true;
            repeating = true;
          })
          (mkExecBindWith "XF86AudioMute" "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" {
            locked = true;
          })
          (mkExecBindWith "XF86AudioMicMute" "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle" {
            locked = true;
          })

          # Brightness
          (mkExecBindWith "XF86MonBrightnessDown" "brightnessctl -e4 -n2 set 5%-" {
            locked = true;
            repeating = true;
          })
          (mkExecBindWith "XF86MonBrightnessUp" "brightnessctl -e4 -n2 set 5%+" {
            locked = true;
            repeating = true;
          })

          # Playerctl
          (mkExecBindWith "XF86AudioPlay" "playerctl play-pause" { locked = true; })
          (mkExecBindWith "XF86AudioPause" "playerctl play-pause" { locked = true; })
          (mkExecBindWith "XF86AudioNext" "playerctl next" { locked = true; })
          (mkExecBindWith "XF86AudioPrev" "playerctl previous" { locked = true; })
          (mkExecBindWith "XF86AudioStop" "playerctl stop" { locked = true; })

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
