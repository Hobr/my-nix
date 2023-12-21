{ inputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  environment.persistence.main = {
    hideMounts = true;
    persistentStoragePath = "/persist";
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
