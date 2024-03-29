{
  description = "Hobr NixOS";

  inputs = {
    # 软件源
    ## 官方稳定
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    ## 官方滚动
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Chaotic
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    # 环境
    ## Rootless
    impermanence.url = "github:nix-community/impermanence";
    ## 用户
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ## 安全启动
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ## 安全
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ## CLI
    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Formatter
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 桌面
    ## Hyprland
    hyprland.url = "github:hyprwm/Hyprland/v0.37.1";
    hypr-idle.url = "github:hyprwm/hypridle/v0.1.1";
    hypr-paper.url = "github:hyprwm/hyprpaper/v0.6.0";
    hypr-picker.url = "github:hyprwm/hyprpicker/v0.2.0";
    hypr-contrib.url = "github:hyprwm/contrib/v0.1";

    # 主題
    catppuccin-hyprland = {
      url = "github:catppuccin/hyprland";
      flake = false;
    };
    catppuccin-qtcreator = {
      url = "github:catppuccin/qtcreator";
      flake = false;
    };
    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };
    catppuccin-btop = {
      url = "github:catppuccin/btop";
      flake = false;
    };
    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };
    catppuccin-zsh = {
      url = "github:catppuccin/zsh-syntax-highlighting";
      flake = false;
    };
    catppuccin-swaylock = {
      url = "github:catppuccin/swaylock";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [
      "x86_64-linux"
      "i686-linux"
      "aarch64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    packages = forAllSystems (system: import ./pkg nixpkgs.legacyPackages.${system});
    overlays = import ./overlay {inherit inputs;};
    nixosModules = import ./module/system;
    homeManagerModules = import ./modules/home;

    nixosConfigurations = {
      # Laptop
      handsonic = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./system/handsonic.nix];
      };

      # Pad
      distortion = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./system/distortion.nix];
      };

      # Server
      overdrive = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./system/overdrive.nix];
      };
    };

    homeConfigurations = {
      # Laptop
      "kanade@handsonic" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [./user/kanade.nix];
      };

      # Pad
      "yuzuru@distortion" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [./user/yuzuru.nix];
      };

      # Server
      "yuri@overdrive" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [./user/yuri.nix];
      };
    };
  };
}
