{
  virtualisation.docker = {
    enable = true;
    liveRestore = true;
    enableOnBoot = true;
    autoPrune.enable = true;
    storageDriver = "btrfs";
  };
}
