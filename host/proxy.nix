{ pkgs, ... }:
{
  programs.proxychains = {
    enable = true;
    # 安静模式
    quietMode = true;

    # 代理
    proxies = {
      myclash = {
        enable = true;
        type = "socks5";
        host = "127.0.0.1";
        port = 7891;
      };
    };
  };

  # Clash
  environment.systemPackages = [ pkgs.unstable.clash-meta ];

  # 守护进程
  systemd.user.services.Mihomo = {
    Unit = {
      Description = "Mihomo daemon, another Clash Kernel.";
    };
    Service = {
      Type = "simple";
      LimitNPROC = "500";
      LimitNOFILE = "1000000";
      CapabilityBoundingSet = "CAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE CAP_SYS_TIME";
      AmbientCapabilities = "CAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE CAP_SYS_TIME";
      Restart = "always";
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 1s";
      ExecStartPre = "${pkgs.wget}/bin/wget -O /home/hobr/.config/mihomo/config.yaml https://conv.trafficmanager.net/sub?target=clash&url=https://yy-node.trafficmanager.net/link/ArDF5nbkrwv0dqcD?sub=2&udp=true&extend=1&filename=yy";
      ExecStart = "${pkgs.mihomo}/bin/mihomo -d /home/hobr/.config/mihomo";
      ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
    };
    Install = {
      WantedBy = [ "multi-user.target" ];
    };
  };

  # 定时更新订阅
  systemd.user.timers.SubUpdate = {
    Unit = {
      Description = "Mihomo subscription update.";
      After = "NetworkManager.service";
    };
    Timer = {
      OnCalendar = "hourly";
      Persistent = "true";
      Unit = "Mihomo.service";
    };
    Install = {
      WantedBy = [ "timers.target" "multi-user.target" ];
    };
  };
}
