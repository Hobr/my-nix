{ config, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # Libinput
  services.xserver.libinput.enable = true;

  # Fwupd
  services.fwupd.enable = true;
}
