# Template for server user configuration
# Copy this file and customize for your user
{
  imports = [ ./profiles/server.nix ];

  home = {
    username = "<USERNAME>";
    homeDirectory = "/home/<USERNAME>";
  };

  # 服务器用户通常不需要额外配置
  # 如果需要可以在这里添加用户特定的覆盖配置
}