{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [ ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages

    ];
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "your-username";
    homeDirectory = "/home/your-username";
  };

  programs.neovim.enable = true;
  home.packages = with pkgs; [ steam ];

  programs.home-manager.enable = true;
  programs.git.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.05";
}
