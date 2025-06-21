{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.sys.boot.tpm;
in
{
  options.sys.boot.tpm.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    security.tpm2 = {
      enable = true;
      tctiEnvironment.enable = true;
      pkcs11.enable = false;
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
        tpm2.enable = true;
      };
    };

  };
}
