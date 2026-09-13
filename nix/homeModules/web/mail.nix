{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.home.web.mail;
in
{
  options.home.web.mail.enable = mkEnableOption "mail";

  config = mkIf cfg.enable {
    programs.thunderbird = {
      enable = true;
      profiles.hobr = {
        isDefault = true;
      };
      settings = { };
    };
  };
}
