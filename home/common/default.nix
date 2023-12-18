# 共通 用户入口
{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
  home = {
    username = "kanade";
    homeDirectory = "/home/kanade";
  };

  home.packages = with pkgs; [ btop ];

  programs.home-manager.enable = true;
  programs.git.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}
