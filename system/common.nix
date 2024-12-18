{ inputs, outputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.chaotic.nixosModules.default
    inputs.disko.nixosModules.disko
    inputs.impermanence.nixosModules.impermanence
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.cosmic.nixosModules.default
    inputs.solaar.nixosModules.default
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
      audio.enable = true;
      bluetooth.enable = true;
    };

    desk = {
      hyprland.enable = true;
      cosmic.enable = false;
    };

    program = {
      shell.enable = true;
      secure.enable = true;
      nh.enable = true;
      proxy.enable = true;
      ld.enable = true;
      virtual.enable = true;
      docker.enable = true;
    };
  };
}
