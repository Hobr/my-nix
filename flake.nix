{
  description = "Hobr NixOS";

  inputs = {
    # 软件源
    ## 官方滚动
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Chaotic
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    # Flake Utils
    flake-utils.url = "github:numtide/flake-utils";
    # linyinfeng's NUR
    lyf = {
      url = "github:linyinfeng/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # 个人NUR
    hobr = {
      url = "github:Hobr/hobr_nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 环境
    ## Rootless
    impermanence.url = "github:nix-community/impermanence";
    ## 安全启动
    lanzaboote.url = "github:nix-community/lanzaboote/v0.3.0";
    ## 用户
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ## 安全
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Xilint
    nix-xilinx = {
      url = "gitlab:doronbehar/nix-xilinx";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # 罗技
    solaar = {
      url = "github:Svenum/Solaar-Flake/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 桌面
    ## Hyprland
    hyprland.url = "github:hyprwm/Hyprland/v0.40.0";
    hypridle.url = "github:hyprwm/hypridle/v0.1.1";
    hyprpaper.url = "github:hyprwm/hyprpaper";
    hyprpicker.url = "github:hyprwm/hyprpicker/v0.2.0";
    hyprcontrib.url = "github:hyprwm/contrib/v0.1";

    # 主题
    catppuccin.url = "github:catppuccin/nix/a48e70a31616cb63e4794fd3465bff1835cc4246";
    ## ZSH
    catppuccin-zsh = {
      url = "github:catppuccin/zsh-syntax-highlighting";
      flake = false;
    };
    # QT Creator
    catppuccin-qtcreator = {
      url = "github:catppuccin/qtcreator";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      systems = [
        "x86_64-linux"
        "i686-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      overlays = import ./overlay { inherit inputs; };
      nixosModules = import ./module/system;
      homeManagerModules = import ./modules/home;

      nixosConfigurations = {
        # Laptop
        handsonic = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./system/handsonic.nix ];
        };

        # Pad
        distortion = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./system/distortion.nix ];
        };

        # Server
        overdrive = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./system/overdrive.nix ];
        };
      };

      homeConfigurations = {
        # Laptop
        "kanade@handsonic" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./user/kanade.nix ];
        };

        # Pad
        "yuzuru@distortion" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./user/yuzuru.nix ];
        };

        # Server
        "yuri@overdrive" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./user/yuri.nix ];
        };
      };
    };
}
