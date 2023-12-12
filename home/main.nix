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

    ./wm/dunst.nix
    ./wm/Hyprland.nix
    ./wm/rofi.nix
    ./wm/waybar.nix

    ./console/alacritty.nix
    ./console/zsh.nix

    ./net/firefox.nix
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
  programs.git = {
    enable = true;
    userName = "Hobr";
    userEmail = "mail@hobr.site";
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  systemd.user.startServices = "sd-switch";

}
