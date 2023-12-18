{
  sound.enable = true;
  hardware.pulseaudio.enable = false;

  # Pipewire
  services.pipewire = {
    enable = true;
    package = pkgs.unstable.pipewire;

    # 主音频服务器
    audio.enable = true;

    # 管理器
    wireplumber.enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
