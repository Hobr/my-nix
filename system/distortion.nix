{
  imports = [
    ./common

    ./distortion/kernel.nix
    ./distortion/filesystem.nix
    ./distortion/hardware.nix
    ./distortion/power.nix
  ];

  # 主机名
  networking.hostName = "distortion";

  # 用户
  users.users = {
    yuzuru = {
      isNormalUser = true;
      uid = 1000;
      hashedPassword = "$y$j9T$C0UuVeSpwcZT/Ig7k/IIK0$W0jxMqKUPiExoWaQ0TWiO8ZL9I5eg2t5MH8N/EBz2B0";
      extraGroups = [
        "wheel"
        "networkmanager"
        "tss"
        "dialout"
        "kvm"
        "libvirtd"
        "docker"
      ];
    };
  };

  nix.settings.trusted-users = [ "yuzuru" ];
  services.greetd.settings.initial_session.user = "yuzuru";

  services.snapper.configs = {
    nix.ALLOW_USERS = [ "yuzuru" ];
    persist.ALLOW_USERS = [ "yuzuru" ];
    home.ALLOW_USERS = [ "yuzuru" ];
  };

  # 平台
  nixpkgs.hostPlatform.system = "x86_64-linux";

  # 系统版本
  system.stateVersion = "24.05";

  sys = {
    gpu.intel.enable = true;
  };
}
