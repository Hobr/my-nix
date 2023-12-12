{
  description = "Hobr's NixOS";

  inputs = {
    # 软件包
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # 环境
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , hyprland
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      systems = "x86_64-linux";
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      overlays = import ./overlays { inherit inputs; };
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        hobr-nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./system/main.nix
          ];
        };
      };

      homeConfigurations = {
        "hobr@hobr-nixos" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home/main.nix
          ];
        };
      };
    };
}
