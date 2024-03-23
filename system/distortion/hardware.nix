{config, ...}: {
  # CPU微码
  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;

  # 雷电
  services.hardware.bolt.enable = false;

  # 打印机
  services.printing.enable = false;

  # 汉王手写笔
  services.xserver.wacom.enable = true;
}
