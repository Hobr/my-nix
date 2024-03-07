{ inputs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.chaotic.nixosModules.default
    inputs.impermanence.nixosModules.impermanence
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.nh.nixosModules.default

    ./common

    ./handsonic/kernel.nix
    ./handsonic/filesystem.nix
    ./handsonic/gpu.nix
    ./handsonic/hardware.nix
    ./handsonic/user.nix
    ./handsonic/power.nix
    ./handsonic/shell.nix
  ];
}
