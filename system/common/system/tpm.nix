{
  security.tpm2 = {
    enable = true;
    tctiEnvironment.enable = true;
    pkcs11.enable = true;
    abrmd.enable = false;
  };

  boot.initrd = {
    availableKernelModules = [
      "tpm"
      "tpm_tis"
      "tpm_crb"
    ];
    systemd = {
      enable = true;
      enableTpm2 = true;
    };
  };
}
