{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.system.audio;
in
{
  options.system.audio.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    hardware.pulseaudio.enable = false;

    # Pipewire
    services.pipewire = {
      enable = true;

      # 主音频服务器
      audio.enable = true;
      # 管理器
      wireplumber.enable = true;
      # 兼容
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    environment.systemPackages = with pkgs; [
      pamixer
      pavucontrol
    ];
  };
}
