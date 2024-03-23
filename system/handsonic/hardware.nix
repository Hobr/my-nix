{config, ...}: {
  # CPU微码
  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;

  # 雷电
  services.hardware.bolt.enable = true;

  # 打印机
  services.printing.enable = false;
}
