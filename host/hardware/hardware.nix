{ config, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # CPU微码
  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;

  # Libinput
  services.xserver.libinput.enable = true;

  # 雷电
  services.hardware.bolt.enable = true;

  services.printing.enable = false;
}
