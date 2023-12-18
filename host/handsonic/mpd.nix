{
  services.mpd = {
    enable = true;
    musicDirectory = "/hobr/hobr/Music";

    # 监听
    network.listenAddress = "any";
    # 连接后启动
    startWhenNeeded = true;

    # 与pipewire使用同一用户
    user = "kanade";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
    '';
  };

  systemd.services.mpd.environment = {
    # uid1000必须为mpd.user的id
    XDG_RUNTIME_DIR = "/run/user/1000";
  };
}
