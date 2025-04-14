{
  inputs,
  outputs,
  lib,
  pkgs,
  ...
}:
with lib;
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.chaotic.nixosModules.default
    inputs.impermanence.nixosModules.impermanence
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.solaar.nixosModules.default
    inputs.stylix.nixosModules.stylix

    outputs.nixosModules

    ./overdrive/kernel.nix
    ./overdrive/filesystem.nix
    ./overdrive/hardware.nix
  ];

  sys = {
    config = {
      nix.enable = true;
      kernel.enable = true;
      locale.enable = true;
    };

    program = {
      virtual.enable = true;
      docker.enable = true;
    };

    disk = {
      persist.enable = true;
      device.enable = true;
    };

    boot.systemd-boot.enable = true;

    io = {
      driver.enable = true;
      network.enable = true;
    };

    program = {
      shell.enable = true;
      secure.enable = true;
      nh.enable = true;
      ld.enable = true;
      proxy.enable = true;
    };
  };

  # 平台
  nixpkgs.hostPlatform.system = "x86_64-linux";

  # 系统版本
  system.stateVersion = "25.05";

  # 主机名
  networking.hostName = "overdrive";

  # 内核
  boot.kernelPackages = mkForce pkgs.linuxPackages_cachyos-server;

  # 用户
  users.users = {
    yuri = {
      isNormalUser = true;
      uid = 1000;
      hashedPassword = "$y$j9T$C0UuVeSpwcZT/Ig7k/IIK0$W0jxMqKUPiExoWaQ0TWiO8ZL9I5eg2t5MH8N/EBz2B0";
      extraGroups = [
        "wheel"
        "networkmanager"
        "tss"
        "dialout"
        "video"
        "docker"
      ];
    };
  };

  nix.settings.trusted-users = [ "yuri" ];
}
