{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.sys.config.kernel;
  mechrevoDmiEntries =
    "\t{\n"
    + "\t\t.matches = {\n"
    + "\t\t\tDMI_MATCH(DMI_SYS_VENDOR, \"MECHREVO\"),\n"
    + "\t\t},\n"
    + "\t},\n"
    + "\t{\n"
    + "\t\t.matches = {\n"
    + "\t\t\tDMI_MATCH(DMI_BOARD_VENDOR, \"MECHREVO\"),\n"
    + "\t\t},\n"
    + "\t},\n"
    + "\t{\n"
    + "\t\t.matches = {\n"
    + "\t\t\tDMI_MATCH(DMI_CHASSIS_VENDOR, \"MECHREVO\"),\n"
    + "\t\t},\n"
    + "\t},\n";
  tuxedoDmiTail = "\t\t\tDMI_MATCH(DMI_CHASSIS_VENDOR, \"TUXEDO\"),\n" + "\t\t},\n" + "\t},\n";
in
{
  options.sys.config.kernel.enable = mkEnableOption "enable";

  config = mkIf cfg.enable {
    # 内核
    boot = {
      # MECHREVO
      kernelPackages = pkgs.linuxPackages_latest.extend (
        final: prev: {
          tuxedo-drivers = prev.tuxedo-drivers.overrideAttrs (old: {
            postPatch = (old.postPatch or "") + ''
              substituteInPlace src/tuxedo_compatibility_check/tuxedo_compatibility_check.c \
                --replace-fail ${lib.escapeShellArg (tuxedoDmiTail + "\t{ }")} \
                ${lib.escapeShellArg (tuxedoDmiTail + "\n" + mechrevoDmiEntries + "\t{ }")}
            '';
          });
        }
      );

      # 内核参数
      kernelParams = [ "systemd.gpt_auto=0" ];
    };

    # scx
    services.scx = {
      enable = true;
      scheduler = "scx_bpfland";
    };

    # Ananicy
    services.ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-rules-cachyos;
    };
  };
}
