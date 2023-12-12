{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    # modules/nixos
    # outputs.nixosModules.example

    # flakes
    # inputs.hardware.nixosModules.common-ssd
  ];

  nixpkgs = {
    overlays = [
      # overlays/pkgs
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # neovim-nightly-overlay.overlays.default

    ];
    config = {
      allowUnfree = true;
    };
  };

  nix.registry = (lib.mapAttrs (_: flake: { inherit flake; })) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  nix.nixPath = [ "/etc/nix/path" ];
  environment.etc =
    lib.mapAttrs'
      (name: value: {
        name = "nix/path/${name}";
        value.source = value.flake;
      })
      config.nix.registry;

  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  networking.hostName = "hobr-nixos";

  boot.loader.systemd-boot.enable = true;

  users.users = {
    hobr = {
      isNormalUser = true;
      extraGroups = [ "wheel" ,"networkmanager", "audio"];
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  system.stateVersion = "23.11";
  nixpkgs.hostPlatform = "x86_64-linux";
}
