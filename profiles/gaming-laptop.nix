# Gaming laptop profile
# For high-performance laptops with full desktop environment and gaming capabilities
{
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  imports = [
    ./base.nix
    inputs.stylix.nixosModules.stylix
    inputs.solaar.nixosModules.default
  ];

  sys = {
    io = {
      audio.enable = true;
      bluetooth.enable = true;
    };

    desk = {
      hyprland.enable = true;
    };

    program = {
      proxy.enable = true;
      zerotier.enable = true;
      virtual.enable = true;
      docker.enable = true;
    };
  };

  # 主题
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/sakura.yaml";

    # 指针
    cursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
    };

    # 字体
    fonts = {
      sizes = {
        # 程序
        applications = 12;
        # 桌面
        desktop = 10;
        # 弹出
        popups = 10;
        # 终端
        terminal = 12;
      };

      serif = {
        package = pkgs.sarasa-gothic;
        name = "Sarasa UI SC";
      };

      sansSerif = {
        package = pkgs.sarasa-gothic;
        name = "Sarasa UI SC";
      };

      monospace = {
        package = pkgs.sarasa-gothic;
        name = "Sarasa Mono SC";
      };

      emoji = {
        package = pkgs.twitter-color-emoji;
        name = "Twemoji";
      };
    };
  };

  fonts = {
    packages = with pkgs; [
      sarasa-gothic
      twitter-color-emoji

      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
    ];
  };
}