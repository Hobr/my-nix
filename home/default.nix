{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./impermanence.nix
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
    username = "hobr";
    homeDirectory = "/home/hobr";
  };

  programs.neovim.enable = true;
  home.packages = with pkgs; [ btop ];

  programs.home-manager.enable = true;
  programs.git.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}
