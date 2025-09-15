# Template for portable laptop system configuration
# Copy this file and customize for your device
{
  imports = [
    ../profiles/portable-laptop.nix

    # 添加你的硬件配置文件
    ./<HOSTNAME>/kernel.nix
    ./<HOSTNAME>/filesystem.nix
    ./<HOSTNAME>/hardware.nix
  ];

  # 主机名
  networking.hostName = "<HOSTNAME>";

  # 用户
  users.users = {
    <USERNAME> = {
      isNormalUser = true;
      uid = 1000;
      hashedPassword = "<HASHED_PASSWORD>";
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

  nix.settings.trusted-users = [ "<USERNAME>" ];
  services.greetd.settings.initial_session.user = "<USERNAME>";
  sys.program.ssh.user = "<USERNAME>";

  sys = {
    # 便携本特定配置
    gpu.intel.enable = true; # 通常便携本使用集成显卡

    program = {
      # 便携本节省资源，继承 portable-laptop profile 配置
      virtual.enable = false;
      docker.enable = false;
    };
  };
}