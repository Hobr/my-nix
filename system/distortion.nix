{
  imports = [
    ./common.nix

    ./distortion/kernel.nix
    ./distortion/filesystem.nix
    ./distortion/hardware.nix
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
        "video"
      ];
    };
  };

  nix.settings.trusted-users = [ "yuzuru" ];
  services.greetd.settings.initial_session.user = "yuzuru";

  sys = {
    gpu.intel.enable = true;
    program.ollama.enable = false;
  };
}
