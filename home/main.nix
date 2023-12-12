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

    ./wm/hyprland.nix
    ./wm/waybar.nix
    ./wm/dunst.nix
    ./wm/rofi.nix

    ./console/alacritty.nix
    ./console/zsh.nix

    ./net/firefox.nix

    ./dev/git.nix
    ./dev/nvim.nix

    ./tool/gnu.nix
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

  programs.home-manager.enable = true;
  home.packages = (with pkgs; [ xmake ]) ++ (with pkgs.unstable; [ cmake ]);

  systemd.user.startServices = "sd-switch";
}
