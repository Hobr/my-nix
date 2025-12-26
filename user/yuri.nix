{
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  imports = [
    outputs.homeModules
  ];

  home = {
    username = "yuri";
    homeDirectory = "/home/yuri";
    stateVersion = "26.05";

    proxy.enable = true;
    web.download.enable = true;
    software.zsh.enable = true;
    media.video.enable = true;

    dev = {
      git.enable = true;
      gpg.enable = true;
      direnv.enable = true;
      util.enable = true;
      editor.nvim = true;
    };

    util = {
      gnu.enable = true;
      ssh.enable = true;
      disk.enable = true;
      cli.enable = true;
    };
  };
}
