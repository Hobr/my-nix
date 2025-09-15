# Base configuration for all devices
# Contains minimal common settings that every device needs
{
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.chaotic.nixosModules.default
    inputs.impermanence.nixosModules.impermanence
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.agenix.nixosModules.default

    outputs.nixosModules
  ];

  sys = {
    config = {
      nix.enable = true;
      kernel.enable = true;
      locale.enable = true;
    };

    disk = {
      persist.enable = true;
      device.enable = true;
    };

    boot = {
      systemd-boot.enable = true;
      tpm.enable = true;
      secure-boot.enable = true;
    };

    io = {
      driver.enable = true;
      network.enable = true;
    };

    program = {
      shell.enable = true;
      secure.enable = true;
      nh.enable = true;
      ld.enable = true;
      ssh.enable = true;
    };
  };

  # Platform - can be overridden by device-specific config
  nixpkgs.hostPlatform.system = "x86_64-linux";
  # System version
  system.stateVersion = "25.11";
}