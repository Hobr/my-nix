{
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  imports = [
    outputs.homeManagerModules
  ];

  home = {
    username = "yuri";
    homeDirectory = "/home/yuri";
    stateVersion = "25.05";

    web.download.enable = true;
    software.zsh.enable = true;

    dev = {
      git.enable = true;
      gpg.enable = true;
      nix.enable = true;
      direnv.enable = true;
      util.enable = true;
      editor.nvim = true;
    };

    util = {
      gnu.enable = true;
      disk.enable = true;
      cli.enable = true;
    };
  };
}
