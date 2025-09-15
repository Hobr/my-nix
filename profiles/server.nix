# Server profile
# For servers without desktop environment, minimal system
{
  inputs,
  outputs,
  lib,
  ...
}:
with lib;
{
  imports = [
    ./base.nix
  ];

  sys = {
    # 服务器不需要音频和蓝牙
    io = {
      audio.enable = false;
      bluetooth.enable = false;
    };

    # 服务器不需要桌面环境
    desk = {
      hyprland.enable = false;
    };

    program = {
      proxy.enable = true;
      zerotier.enable = true;
      virtual.enable = true;
      docker.enable = true;
    };
  };

  # 服务器不需要主题和字体配置
  # stylix.enable = false; # 由于base.nix中没有默认启用，这里不需要明确禁用
}