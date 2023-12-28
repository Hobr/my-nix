{ pkgs, lib, ... }:
{
  security.tpm2 = {
    enable = true;
    abrmd.enable = true;
    tctiEnvironment.enable = true;
    pkcs11.enable = true;
  };

  environment.systemPackages = lib.mkAfter [ pkgs.tpm2-tools ];
  # 用户组
  users.users.kanade.extraGroups = [ "tss" ];
  boot.initrd.availableKernelModules = lib.mkAfter [ "tpm_crb" ];
  boot.initrd.systemd.enableTpm2 = true;
}
