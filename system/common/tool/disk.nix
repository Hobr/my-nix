{
  # Snapper
  services.snapper = {
    snapshotInterval = "daily";
    cleanupInterval = "3d";
    configs = {
      nix = {
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        SUBVOLUME = "/nix";
        ALLOW_GROUPS = [ "wheel" ];
      };
      persist = {
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        SUBVOLUME = "/persist";
        ALLOW_GROUPS = [ "wheel" ];
      };
      home = {
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        SUBVOLUME = "/home";
        ALLOW_GROUPS = [ "wheel" ];
      };
    };
  };

  # SSD Trim
  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  # Btrfs Scrub
  services.btrfs.autoScrub = {
    enable = true;
    fileSystems = [ "/nix" "/home" "/persist" ];
    interval = "weekly";
  };

  # GVFS
  services.gvfs.enable = true;

  # 挂载
  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };
}
