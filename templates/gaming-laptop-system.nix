# Template for gaming laptop system configuration
# Copy this file and customize for your device
{
  imports = [
    ../profiles/gaming-laptop.nix

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
    # Gaming laptop 特定配置
    gpu.nvidia.enable = true; # 或 gpu.intel.enable = true; 或 gpu.amd.enable = true;

    program = {
      # 游戏本启用所有功能，继承 gaming-laptop profile 配置
      virtual.enable = true;
      docker.enable = true;
    };
  };
}