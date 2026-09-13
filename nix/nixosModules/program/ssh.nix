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

    users.users."${cfg.user}".openssh.authorizedKeys.keys = [
      # Handsonic
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8VGTWsM1bXg5RUcaEvr+4ualB0DJnDXbB3nNQmMd1p0yXqqZOQ3CfYpgSl23Oo3FgflNSbibTk/8g0wPBjalBFSNyZ/4DfC6RWD3YVuqIZCPkGGPD37JiIGHcw1s2tPGojonIytTcHc/xF+zG72FcVtkcOSLXM2xkk9oEZ/ElJe0SQ61J5uBvLJm4pKftg9a9sGRN75VqGvzbDKzKWdOq4gLq/q151NUAGSryirfXTmPZiGZS7jg9O2zUrdC59gE0y2nTwLWXW3MrMj/qAQuLpge8cNhCaUw3KLYwYxtOUOOvNfDtZculf6R81Em/XjMOCdJ0DFhlcv1uCYuAgMU35yqVbyPaAJQvb+A4uGtKxx0AoVghBLaWxoMUXLQCUyr56q1Dpjg+QwXwkRXFssLQefMR+PojyQKYnFIE/ikNVj83iOA9C3rVLoiyV743xfum5QtHj0fQN0c+1sWiSRx7vr9dIcFpxRx9K06Mf7S9aJ+7t3YoXr1XYYc9v8XmiLc= mail@hobr.site"
      # OnePlus
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCeoVo+DLmHz79cSeaKtexpb/U1ZiEZA90j9W38ot2gML025KidQeE9CMllpntn6/YX9X9NRhLkee/36ERkX7dNOCihXKdJL65w3Z93+9Qc5BDBFWJeTulKgYsbZAz4O2v0dUOnpwIXUWAumlrxDNFAa/MQdg1As+FOufoelLygI4xcd3dm0o0dgErQhGRGqKOlt/U56G1Bw28mXdoMW17GoYP0adFXzIQc8xWUMWWe+4SX/M5hkZ2traIFr4fqMyHauty7kjUFvaIZwr7F+kxRVmJpDVUYMd/T/88wJoEKgp0L6ZSGGGDeu0hmYa+7/RoCJo+n6hMgsTSFWy25nQiT mail@hobr.site"
    ];
  };
}
