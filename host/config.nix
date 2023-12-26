{
  # 平台
  nixpkgs.hostPlatform = {
    gcc.arch = "tigerlake";
    gcc.tune = "tigerlake";
    system = "x86_64-linux";
  };

  # 系统版本
  system.stateVersion = "23.11";
}
