{ inputs
, ...
}:
{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  # TPM
  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    tctiEnvironment.enable = true;
  };

  users.users.hobr.extraGroups = [ "tss" ];

  boot.initrd = {
    systemd.enable = true;
    kernelModules = [ "tpm" "tpm_tis" "tpm_crb" ];
  };

  # Secure Boot
  boot.lanzaboote = {
    enable = true;
    publicKeyFile = "/etc/secureboot/keys/db/db.pem";
    privateKeyFile = "/etc/secureboot/keys/db/db.key";
  };
}
