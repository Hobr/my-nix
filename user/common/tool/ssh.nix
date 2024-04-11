{ pkgs, ... }: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "ssh.github.com";
        user = "git";
        port = 443;
        proxyCommand =
          "${pkgs.unstable.netcat}/bin/nc -v -x 127.0.0.1:7891 %h %p";
      };
    };
  };

  services.ssh-agent.enable = true;
}
