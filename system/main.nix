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

    ./hardware/nix.nix
    ./hardware/system.nix
    ./hardware/disk.nix
    ./hardware/boot.nix
    ./hardware/network.nix
    ./hardware/nvidia.nix
    ./hardware/audio.nix
    ./hardware/bluetooth.nix
    ./hardware/locale.nix

    ./desktop/xdg.nix
    ./desktop/font.nix

    ./dev/docker.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  security.rtkit.enable = true;

  users.users = {
    hobr = {
      isNormalUser = true;
      extraGroups = [ "wheel" ,"networkmanager", "audio" ];
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
}
