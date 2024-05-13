{
  virtualisation.docker = {
    enable = true;
    liveRestore = true;
    enableOnBoot = true;
    autoPrune.enable = true;
    storageDriver = "btrfs";
    daemon.settings = {
      registry-mirrors = [ "https://dockerproxy.com" ];
    };
  };
}
