# Template for server system configuration  
# Copy this file and customize for your device
{
  imports = [
    ../profiles/server.nix

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
  sys.program.ssh.user = "<USERNAME>";

  sys = {
    # 服务器特定配置，继承 server profile 配置
    # 可以在这里添加服务器特定的覆盖配置
  };
}