# Base user configuration for all users
# Contains minimal common settings
{
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.chaotic.homeManagerModules.default
    outputs.homeModules
  ];

  home = {
    # 系统版本号
    stateVersion = "25.11";

    software = {
      terminal.enable = true;
      zsh.enable = true;
    };

    dev = {
      git.enable = true;
      gpg.enable = true;
      nix.enable = true;
      direnv.enable = true;
      util.enable = true;
    };

    util = {
      gnu.enable = true;
      ssh.enable = true;
      disk.enable = true;
      file.enable = true;
      cli.enable = true;
    };
  };
}