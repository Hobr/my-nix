{ inputs, outputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.chaotic.nixosModules.default
    inputs.impermanence.nixosModules.impermanence
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.hyprland.nixosModules.default
    inputs.solaar.nixosModules.default

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
      snapper.enable = true;
    };

    boot = {
      systemd-boot.enable = true;
      tpm.enable = true;
      secure-boot.enable = true;
    };

    system = {
      driver.enable = true;
      network.enable = true;
      audio.enable = true;
      bluetooth.enable = true;
    };

    desk = {
      hyprland.enable = true;
    };

    program = {
      shell.enable = true;
      secure.enable = true;
      nh.enable = true;
      proxy.enable = true;
      ld.enable = true;
      virtual.enable = true;
      docker.enable = true;
      steam.enable = true;
    };
  };
}