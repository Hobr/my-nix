{
  description = "Hobr NixOS";

  inputs = {
    # 软件源
    ## 官方稳定源
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    ## 官方滚动源
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    ## 用户源
    nur.url = "github:nix-community/NUR";
    ## Wayland包
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 环境
    ## 硬件
    hardware.url = "github:nixos/nixos-hardware";
    ## 无状态
    impermanence.url = "github:nix-community/impermanence";

    ## 用户管理
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ## 分区
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ## Secure Boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixos";
    };
    ## 沙箱
    nixpak = {
      url = "github:nixpak/nixpak";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ## 密钥管理
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
    ## Nix Cli助手
    nh = {
      url = "github:viperml/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 桌面环境
    ## Hyrpland
    hyprland.url = "github:hyprwm/Hyprland";
    ## XDG门户
    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    ## Hyprland插件
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    ## 颜色选择器
    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 语言
    ## Rust
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      inherit (self) outputs;
      systems = [
        "x86_64-linux"
        "i686-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (system: import ./pkg nixpkgs.legacyPackages.${system});
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
      overlays = import ./overlay { inherit inputs; };
      nixosModules = import ./module/system;
      homeManagerModules = import ./module/home;
      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });

      nixosConfigurations = {
        # UmiPro3 系统
        handsonic = nixpkgs.lib.nixosSystem {
          modules = [ ./host/handsonic ];
          specialArgs = { inherit inputs outputs; };
        };

        # 美国VPS 系统
        distortion = nixpkgs.lib.nixosSystem {
          modules = [ ./host/distortion ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      homeConfigurations = {
        # UmiPro3 用户
        "kanade@handsonic" = home-manager.lib.homeManagerConfiguration {
          modules = [ ./home/handsonic ];
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };

        # 美国VPS 用户
        "kanade@distortion" = home-manager.lib.homeManagerConfiguration {
          modules = [ ./home/distortion ];
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
