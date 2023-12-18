{ lib, ... }:
{
  # Docker
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };
  users.users.kanade.extraGroups = lib.mkAfter [ "docker" ];
}
