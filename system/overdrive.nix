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
    ../profiles/nas.nix

    ./overdrive/kernel.nix
    ./overdrive/filesystem.nix
    ./overdrive/hardware.nix
  ];

  sys = {
    # NAS 不需要额外的GPU配置，继承 server profile 配置
    program.ssh.user = "yuri";
  };

  # 主机名
  networking.hostName = "overdrive";

  # 用户
  users.users = {
    yuri = {
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

  nix.settings.trusted-users = [ "yuri" ];
}
