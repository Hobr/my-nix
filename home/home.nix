{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    # modules/home-manager
    # outputs.homeManagerModules.example

    # flakes
    # inputs.nix-colors.homeManagerModules.default
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
    homeDirectory = "hobr";
  };

  programs.neovim.enable = true;
  home.packages = with pkgs; [ xmake ];

  programs.home-manager.enable = true;
  programs.git.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}
