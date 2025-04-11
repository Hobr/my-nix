{
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.stylix.homeManagerModules.stylix

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

      editor = {
        nvim = true;
        emacs = true;
      };
    };

    util = {
      gnu.enable = true;
      disk.enable = true;
      cli.enable = true;
    };
  };

  services.ssh-agent.enable = true;
}
