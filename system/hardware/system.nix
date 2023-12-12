{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  fileSystems =
    {};

  swapDevices =
    [
    ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
