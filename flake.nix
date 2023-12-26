{
  description = "Hobr NixOS";

  inputs = {
    # 软件源
    ## 官方稳定源
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    ## 官方滚动源
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    ## 用户源 TODO
    nur.url = "github:nix-community/NUR";
    ## Wayland包 TODO
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ## 个人NUR源 TODO
    hobr-nur = {
      url = "github:Hobr/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 环境
    ## 硬件 TODO
    hardware.url = "github:nixos/nixos-hardware";
    ## 无状态 TODO
    impermanence.url = "github:nix-community/impermanence";
    ## 密钥管理 TODO
    agenix.url = "github:ryantm/agenix";
    ## 用户管理
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ## Secure Boot TODO
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixos";
    };
    ## 沙箱 TODO
    nixpak = {
      url = "github:nixpak/nixpak";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ## CLI TODO
    nh = {
      url = "github:viperml/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 桌面环境
    ## Hyrpland TODO
    hyprland.url = "github:hyprwm/Hyprland";
    ## XDG TODO
    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    ## 插件 TODO
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    ## 颜色选择器 TODO
    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 语言
    ## Rust TODO
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 配置文件
    ## LightDM TODO
    lightdm-gab-gradient = {
      url = "github:GabrielTenma/lightdm-gab-gradient";
      flake = false;
    };
    ## 我的NVim配置 TODO
    nvim-config = {
      url = "github:Hobr/myNeoVim";
      flake = false;
    };
    # Catppuccin 主题 TODO
    ## 界面
    catppuccin-cursors = {
      url = "github:catppuccin/cursors";
      flake = false;
    };
    catppuccin-gtk = {
      url = "github:catppuccin/gtk";
      flake = false;
    };
    catppuccin-qt5ct = {
      url = "github:catppuccin/qt5ct";
      flake = false;
    };
    catppuccin-tty = {
      url = "github:catppuccin/tty";
      flake = false;
    };
    catppuccin-xresources = {
      url = "github:catppuccin/xresources";
      flake = false;
    };
    ## CLI
    catppuccin-zsh-syntax-highlighting = {
      url = "github:catppuccin/zsh-syntax-highlighting";
      flake = false;
    };
    catppuccin-btop = {
      url = "github:catppuccin/btop";
      flake = false;
    };
    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };
    catppuccin-fzf = {
      url = "github:catppuccin/fzf";
      flake = false;
    };
    ## 软件
    catppuccin-hyprland = {
      url = "github:catppuccin/hyprland";
      flake = false;
    };
    catppuccin-waybar = {
      url = "github:catppuccin/waybar";
      flake = false;
    };
    catppuccin-dunst = {
      url = "github:catppuccin/dunst";
      flake = false;
    };
    catppuccin-rofi = {
      url = "github:catppuccin/rofi";
      flake = false;
    };
    catppuccin-alacritty = {
      url = "github:catppuccin/alacritty";
      flake = false;
    };
    catppuccin-plymouth = {
      url = "github:catppuccin/plymouth";
      flake = false;
    };
    catppuccin-fcitx5 = {
      url = "github:catppuccin/fcitx5";
      flake = false;
    };
    catppuccin-qtcreator = {
      url = "github:catppuccin/qtcreator";
      flake = false;
    };
    catppuccin-cutter = {
      url = "github:catppuccin/cutter";
      flake = false;
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
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    nixosConfigurations = {
      handsonic = nixpkgs.lib.nixosSystem {
        modules = [ ./host ];
        specialArgs = { inherit inputs outputs; };
      };
    };

    homeConfigurations = {
      "kanade@handsonic" = home-manager.lib.homeManagerConfiguration {
        modules = [ ./home ];
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs outputs; };
      };
    };
  };
}
