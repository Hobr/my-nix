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
        "docker"
      ];
    };
  };

  nix.settings.trusted-users = [ "kanade" ];
  services.greetd.settings.initial_session.user = "kanade";

  sys = {
    gpu.nvidia.enable = true;

    program = {
      ollama.enable = true;
      virtual.enable = true;
      docker.enable = true;
    };
  };
}
