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

    ./console/alacritty.nix
    ./console/zsh.nix

    ./wm/dunst.nix
    ./wm/Hyprland.nix
    ./wm/rofi.nix
    ./wm/waybar.nix
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
    stateVersion = "23.11";
  };

  programs.neovim.enable = true;
  home.packages = (with pkgs; [ xmake ]) ++ (with pkgs.unstable; [ cmake ]);

  programs.home-manager.enable = true;
  programs.git.enable = true;

  systemd.user.startServices = "sd-switch";

}
