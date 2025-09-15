# NAS profile
# For Network Attached Storage systems, server-like but with storage-specific features
{
  inputs,
  outputs,
  lib,
  pkgs,
  ...
}:
with lib;
{
  imports = [
    ./server.nix
  ];

  # NAS 特定的配置可以在这里添加
  # 例如: ZFS, RAID管理, 存储服务等

  # 使用特定的服务器内核
  boot.kernelPackages = mkForce pkgs.linuxPackages_cachyos-server;
}