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

    ./desktop/user.nix
    ./desktop/xdg.nix
    ./desktop/font.nix
    ./desktop/ssh.nix
    ./desktop/secure.nix

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

  system.stateVersion = "23.11";
}
