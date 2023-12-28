{ inputs, ... }:
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib"

      "/etc"
      "/root"
    ];
    files = [ ];
  };
}
