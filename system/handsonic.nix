{ lib, ... }:
{
  imports = [
    ./common

    ./handsonic/kernel.nix
    ./handsonic/filesystem.nix
    ./handsonic/gpu.nix
    ./handsonic/hardware.nix
    ./handsonic/power.nix
  ];

  # 主机名
  networking.hostName = "handsonic";

  # 用户
  users.users = {
    kanade = {
      isNormalUser = true;
      uid = 1000;
      hashedPassword = "$y$j9T$C0UuVeSpwcZT/Ig7k/IIK0$W0jxMqKUPiExoWaQ0TWiO8ZL9I5eg2t5MH8N/EBz2B0";
      extraGroups = lib.mkAfter [ "wheel" "networkmanager" "tss" ];
    };
  };

  nix.settings.trusted-users = [ "kanade" ];
  services.greetd.settings.initial_session.user = "kanade";

  services.snapper.configs = {
    nix.ALLOW_USERS = [ "kanade" ];
    persist.ALLOW_USERS = [ "kanade" ];
    home.ALLOW_USERS = [ "kanade" ];
  };

  # 平台
  nixpkgs.hostPlatform.system = "x86_64-linux";

  # 系统版本
  system.stateVersion = "23.11";
}
