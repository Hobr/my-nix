{
  imports = [
    ./common.nix

    ./handsonic/kernel.nix
    ./handsonic/filesystem.nix
    ./handsonic/hardware.nix
  ];

  # 主机名
  networking.hostName = "handsonic";

  # 用户
  users.users = {
    kanade = {
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

  nix.settings.trusted-users = [ "kanade" ];
  services.greetd.settings.initial_session.user = "kanade";

  # 平台
  nixpkgs.hostPlatform.system = "x86_64-linux";

  # CUDA
  nixpkgs.config.cudaSupport = true;

  # 系统版本
  system.stateVersion = "24.11";

  sys = {
    gpu.nvidia.enable = true;
    program.ollama.enable = true;
  };
}
