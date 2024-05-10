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

  hardware.nvidia-container-toolkit = {
    enable = true;
    mount-nvidia-executables = true;
    mount-nvidia-docker-1-directories = true;
  };
}
