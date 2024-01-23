{ pkgs, lib, ... }:
{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host github.com
        Host github.com
        HostName github.com
        User git
        ProxyCommand ${pkgs.unstable.netcat-gnu}/bin/nc -v -x 127.0.0.1:7891 %h %p
    '';
  };

  services.ssh-agent.enable = true;

  # 代理
  home.packages = with pkgs.unstable; lib.mkAfter [ netcat-gnu ];
}
