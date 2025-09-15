{
  imports = [
    ../profiles/portable-laptop.nix

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
        "docker"
        "qemu-libvirtd"
        "libvirtd"
      ];
    };
  };

  nix.settings.trusted-users = [ "yuzuru" ];
  services.greetd.settings.initial_session.user = "yuzuru";
  sys.program.ssh.user = "yuzuru";

  sys = {
    # 便携本特定配置
    gpu.intel.enable = true;

    program = {
      # 便携本节省资源，继承 portable-laptop profile 配置
      virtual.enable = false;
      docker.enable = false;
    };
  };
}
