{ inputs, ... }: {
  imports = [
    inputs.disko.nixosModules.disko;
  ];

  disko.devices = {
    disk.main = {
      content = {
        partitions = {
          luks = {

            swap = {
              content = {
                label = "Swap";
                resumeDevice = true;
                type = "swap";
              };
              size = "100%";
            };
            content = {
              content = {
                label = "NixOS";
                type = "btrfs";
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

              extraOpenArgs = [ "--allow-discards" ];
              name = "crypt";
              passwordFile = "/tmp/secret.key";
              type = "luks";
            };
            end = "-24G";
          };
        };
        type = "gpt";
      };
      device = "/dev/nvme0n1";
      type = "disk";
    };
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [ "defaults" "mode=755" "size=8G" ];
    };
  };
}
