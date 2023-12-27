{
  description = "Hobr NixOS";

  inputs = {
    # 软件源
    ## 官方稳定源
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    ## 官方滚动源
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    ## Wayland包
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 环境
    ## 无状态
    impermanence.url = "github:nix-community/impermanence";
    ## 用户管理
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ## CLI
    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 桌面环境
    ## Hyrpland
    hyprland.url = "github:hyprwm/Hyprland/v0.33.1";
    ## XDG
    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland/v1.2.6";
    ## 插件
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    ## 颜色选择器
    hyprpicker = {
      url = "github:hyprwm/hyprpicker/v0.2.0";
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
      overlays = import ./overlay { inherit inputs; };
      nixosModules = import ./module/system;
      homeManagerModules = import ./module/home;
      packages = forAllSystems (system: import ./pkg nixpkgs.legacyPackages.${system});
      nixosConfigurations = {
        handsonic = nixpkgs.lib.nixosSystem {
          modules = [ ./host ];
          specialArgs = { inherit inputs outputs; };
        };
      };
    };
}
