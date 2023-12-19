{ inputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  environment.persistence.main = {
    persistentStoragePath = "/persistent";
    directories = [
      "/var/log"
      "/var/lib"
      "/etc"
    ];

    files = [
      {
        file = "/var/keys/secret_file";
        parentDirectory = { mode = "u=rwx,g=,o="; };
      }
    ];
  };
}
