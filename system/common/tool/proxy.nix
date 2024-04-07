{pkgs, ...}: {
  programs.proxychains = {
    enable = true;
    package = pkgs.unstable.proxychains-ng;
    quietMode = true;

    # 代理
    proxies = {
      sock = {
        enable = true;
        type = "socks5";
        host = "127.0.0.1";
        port = 7891;
      };
      http = {
        enable = true;
        type = "http";
        host = "127.0.0.1";
        port = 7890;
      };
    };
  };

  # Clash
  environment.systemPackages = [pkgs.unstable.clash-meta];

  # 守护进程
  systemd.services.Clash = {
    unitConfig = {
      Description = "Clash daemon";
      After = "NetworkManager-wait-online.service";
    };
    serviceConfig = {
      Type = "simple";
      LimitNPROC = "500";
      LimitNOFILE = "1000000";
      CapabilityBoundingSet = "CAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE CAP_SYS_TIME";
      AmbientCapabilities = "CAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE CAP_SYS_TIME";
      ExecStartPre = "${pkgs.unstable.wget}/bin/wget -O /etc/clash/config.yaml 'https://convsub.com/sub?target=clash&url=http%3A%2F%2F106.15.207.16%3A40000%2Flink%2FArDF5nbkrwv0dqcD%3Fsub%3D2%26udp%3Dtrue%26extend%3D1%26filename%3Dyy'";
      ExecStart = "${pkgs.unstable.clash-meta}/bin/clash-meta -d /etc/clash";
      ExecReload = "${pkgs.unstable.coreutils}/bin/kill -HUP $MAINPID";
      Restart = "on-failure";
      RestartSec = 3;
    };
    wantedBy = ["multi-user.target"];
  };

  # 定时更新订阅
  systemd.timers.SubUpdate = {
    unitConfig = {
      Description = "Clash subscription update.";
      After = "NetworkManager-wait-online.service";
    };
    timerConfig = {
      OnCalendar = "hourly";
      Persistent = "true";
      Unit = "Clash.service";
    };
    wantedBy = ["timers.target" "multi-user.target"];
  };
}
