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
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8VGTWsM1bXg5RUcaEvr+4ualB0DJnDXbB3nNQmMd1p0yXqqZOQ3CfYpgSl23Oo3FgflNSbibTk/8g0wPBjalBFSNyZ/4DfC6RWD3YVuqIZCPkGGPD37JiIGHcw1s2tPGojonIytTcHc/xF+zG72FcVtkcOSLXM2xkk9oEZ/ElJe0SQ61J5uBvLJm4pKftg9a9sGRN75VqGvzbDKzKWdOq4gLq/q151NUAGSryirfXTmPZiGZS7jg9O2zUrdC59gE0y2nTwLWXW3MrMj/qAQuLpge8cNhCaUw3KLYwYxtOUOOvNfDtZculf6R81Em/XjMOCdJ0DFhlcv1uCYuAgMU35yqVbyPaAJQvb+A4uGtKxx0AoVghBLaWxoMUXLQCUyr56q1Dpjg+QwXwkRXFssLQefMR+PojyQKYnFIE/ikNVj83iOA9C3rVLoiyV743xfum5QtHj0fQN0c+1sWiSRx7vr9dIcFpxRx9K06Mf7S9aJ+7t3YoXr1XYYc9v8XmiLc= mail@hobr.site"
    ];
  };
}
