{ pkgs, lib, ... }:
{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host github.com
        Hostname ssh.github.com
        Port 443
        ProxyCommand ${pkgs.unstable.netcat-gnu}/bin/nc -v -X 5 -x 127.0.0.1:7891 %h %p
    '';
  };

  services.ssh-agent.enable = true;

  # 代理
  home.packages = with pkgs.unstable; lib.mkAfter [ netcat-gnu ];
}
