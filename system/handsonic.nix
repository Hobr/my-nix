{
  imports = [
    ../profiles/gaming-laptop.nix

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
        "qemu-libvirtd"
        "libvirtd"
      ];
    };
  };

  nix.settings.trusted-users = [ "kanade" ];
  services.greetd.settings.initial_session.user = "kanade";
  sys.program.ssh.user = "kanade";

  sys = {
    # 游戏本特定配置
    gpu.nvidia.enable = true;

    program = {
      # 游戏本启用所有功能，继承 gaming-laptop profile 配置
      virtual.enable = true;
      docker.enable = true;
    };
  };
}
