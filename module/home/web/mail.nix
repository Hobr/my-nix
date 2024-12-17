{
  config,
  options,
  lib,
  ...
}:
with lib;
let
  cfg = config.home.software.mail;
in
{
  options.home.software.mail.enable = mkEnableOption "mail";

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
