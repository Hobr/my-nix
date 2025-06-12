{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.sys.program.ssh;
in
{
  options.sys.program.ssh = {
    enable = mkEnableOption "enable";
    user = mkOption {
      type = types.str;
      default = "kanade";
      description = "user";
    };
  };
  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    services.fail2ban.enable = true;

    users.users."${cfg.user}".openssh.authorizedKeys.keys = [
      # Handsonic
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8VGTWsM1bXg5RUcaEvr+4ualB0DJnDXbB3nNQmMd1p0yXqqZOQ3CfYpgSl23Oo3FgflNSbibTk/8g0wPBjalBFSNyZ/4DfC6RWD3YVuqIZCPkGGPD37JiIGHcw1s2tPGojonIytTcHc/xF+zG72FcVtkcOSLXM2xkk9oEZ/ElJe0SQ61J5uBvLJm4pKftg9a9sGRN75VqGvzbDKzKWdOq4gLq/q151NUAGSryirfXTmPZiGZS7jg9O2zUrdC59gE0y2nTwLWXW3MrMj/qAQuLpge8cNhCaUw3KLYwYxtOUOOvNfDtZculf6R81Em/XjMOCdJ0DFhlcv1uCYuAgMU35yqVbyPaAJQvb+A4uGtKxx0AoVghBLaWxoMUXLQCUyr56q1Dpjg+QwXwkRXFssLQefMR+PojyQKYnFIE/ikNVj83iOA9C3rVLoiyV743xfum5QtHj0fQN0c+1sWiSRx7vr9dIcFpxRx9K06Mf7S9aJ+7t3YoXr1XYYc9v8XmiLc= mail@hobr.site"
      # Distortion
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQClsb0O0Pitr2EFZa7RZE8smzKPiz0KNRe2wDYJ9IFpa8NlLqksJjFb5iBiv+QsOl/7fev1yTHzv5E1sJqXfWF7ZQfPnvSflc0qufv60QzWZvaQW3AwVbP2ZZXLPCOtFSuEOVtRtiYjoTpfuT7GpKGJ5wOPH4iCLwg9jwL9sWZAxGIdPBel6pEYToxOm30LItP0SzcajhbTm+Vb0pDCGFUJmr56EBbl/YJapAbAAF8Y7A7oJ5ZXb+yuWRWpUax04Ysc9DrUBh1i22dj5o2g1eFS2wF51YDUBlSouo7+vhrngKlaOVUzGkcVaVcWOmeYTszJX4OS8zregS/Ap0bUIqWrPdLpQhL3IrIAC5kekJl/AFDgWfZAdj6XrtD0H42RN48++rQotUka9bnonRXWHGWHN5uDVXWBVsd/jDkcamiPcVzWTjGxKRguEpnQj0JCglEVf2Ypio3xvqolfupWNlxK4m/QoRQoOMadrbHCnKajqKNPFuXDakc93A5FNZjZ+m0= mail@hobr.site"
      # Overdrive
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDEZ1/XQdhhDVArsO3cq8cgVfNjiuI/XtGM95vUe+yvEvJaHqrAGhMaoOBpJm7Zf2226B2aWiiDC/mxsn8ZlRqWaCahaw1v2E5jxH3NJ2z6DvoFjaP5iNsKO9Yla4QhEbuxrbWLA5krHf1kEuL4NZhq+9rL9o/Cc4BiPo3/TApCsDDzNeHwjBE25OO/Y5HeO2d3zpbhcv/P3lm6beFGk2jLm+c2TTrchvZoH4awxwP5zzzXhmUavN9qD84Uk5WaWuSAdobYhyxupGe4OfmfQBWDRhqHhaIKLcFqZbPgntvSK6ljl1ph4AaHA/EJ4O50fgApDRUykwF8jlgMcbtVa4mUab5/TPtwM70j13aF9xYw8/xfVVJAacq7Tzlun63hAL/YCz0/5Ava+9nNDaSs0SVf52Fhxz82UJ45LFCs+WQdHMbFHTHxcKxbHopBjJ6+RfVRAVydroIipntBOLjjC3ysphDLlVNifPS7NsNPDIz6KO/sWGrilPDkbhYvCSAjdPE= mail@hobr.site"
      # OnePlus
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCeoVo+DLmHz79cSeaKtexpb/U1ZiEZA90j9W38ot2gML025KidQeE9CMllpntn6/YX9X9NRhLkee/36ERkX7dNOCihXKdJL65w3Z93+9Qc5BDBFWJeTulKgYsbZAz4O2v0dUOnpwIXUWAumlrxDNFAa/MQdg1As+FOufoelLygI4xcd3dm0o0dgErQhGRGqKOlt/U56G1Bw28mXdoMW17GoYP0adFXzIQc8xWUMWWe+4SX/M5hkZ2traIFr4fqMyHauty7kjUFvaIZwr7F+kxRVmJpDVUYMd/T/88wJoEKgp0L6ZSGGGDeu0hmYa+7/RoCJo+n6hMgsTSFWy25nQiT mail@hobr.site"
    ];
  };
}
