{
  disko.devices = {
    disk.main = {
      content = {
        partitions = {
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "crypt";
              extraOpenArgs = [ "--allow-discards" ];
              settings = {
                keyFile = "/tmp/secret.key";
                allowDiscards = true;
              };
              content = {
                type = "lvm_pv";
                vg = "system";
              };
            };
          };
        };
        type = "gpt";
      };
      device = "/dev/nvme0n1";
      type = "disk";
    };

    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [ "defaults" "mode=755" "size=2G" ];
    };
  };

  lvm_vg = {
    system = {
      type = "lvm_vg";
      lvs = {
        root = {
          type = "btrfs";
          end = "-16G";
          extraArgs = [ "-f" ];
          subvolumes = {
            "/persistent" = {
              mountpoint = "/persistent";
              mountOptions = [ "compress=zstd" "noatime" ];
            };
            "/home" = {
              mountpoint = "/home";
              mountOptions = [ "compress=zstd" ];
            };
            "/nix" = {
              mountpoint = "/nix";
              mountOptions = [ "compress=zstd" "noatime" ];
            };
          };
        };

        swap = {
          content = {
            type = "swap";
            resumeDevice = true;
            randomEncryption = false;
          };
          size = "100%";
        };
      };
    };
  };
}
