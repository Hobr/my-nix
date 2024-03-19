{ lib, pkgs, ... }:
{
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  hardware.pulseaudio.enable = false;

  # Pipewire
  services.pipewire = {
    enable = true;
    package = pkgs.unstable.pipewire;

    # 主音频服务器
    audio.enable = true;
    # 管理器
    wireplumber = {
      enable = true;
      package = pkgs.unstable.wireplumber;
    };
    # 兼容
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; lib.mkAfter [
    pamixer
    pavucontrol
  ];
}
