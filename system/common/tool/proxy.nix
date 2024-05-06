{ pkgs, ... }: {
  programs.proxychains = {
    enable = true;
    package = pkgs.proxychains-ng;
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

  # Mihomo
  # 守护进程
  systemd.services.Mihomo = {
    unitConfig = {
      Description = "Mihomo daemon";
      After = "NetworkManager-wait-online.service";
    };
    serviceConfig = {
      Type = "simple";
      LimitNPROC = "500";
      LimitNOFILE = "1000000";
      CapabilityBoundingSet =
        "CAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE CAP_SYS_TIME";
      AmbientCapabilities =
        "CAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE CAP_SYS_TIME";
      ExecStartPre =
        "${pkgs.wget}/bin/wget -O /etc/mihomo/config.yaml 'http://106.15.207.16:8899/sub?target=clash&url=http://106.15.207.16:40000/link/ArDF5nbkrwv0dqcD?sub=2&udp=true&extend=1&filename=yy'";
      ExecStart = "${pkgs.mihomo}/bin/mihomo -d /etc/mihomo";
      ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
      Restart = "on-failure";
      RestartSec = 3;
    };
    wantedBy = [ "multi-user.target" ];
  };

  # 定时更新订阅
  systemd.timers.SubUpdate = {
    unitConfig = {
      Description = "Mihomo subscription update.";
      After = "NetworkManager-wait-online.service";
    };
    timerConfig = {
      OnCalendar = "hourly";
      Persistent = "true";
      Unit = "Mihomo.service";
    };
    wantedBy = [ "timers.target" "multi-user.target" ];
  };
}
