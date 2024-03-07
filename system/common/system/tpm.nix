{ lib, ... }:
{
  security.tpm2 = {
    enable = true;
    tctiEnvironment.enable = true;
    pkcs11.enable = true;
    abrmd.enable = true;
  };

  boot.initrd.availableKernelModules = lib.mkAfter [ "tpm" "tpm_tis" "tpm_crb" ];
  boot.initrd.systemd.enableTpm2 = true;
}
