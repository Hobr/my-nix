{ pkgs, ... }:
{
  # 内核
  boot = {
    # 版本
    kernelPackages = pkgs.linuxPackages_cachyos-sched-ext;

    # 内核参数
    consoleLogLevel = 0;
    kernelParams = [ "quiet" "udev.log_level=3" "nowatchdog" "systemd.gpt_auto=0" ];
  };

  # SCX
  environment.systemPackages =  [ pkgs.scx ];

  # Ananicy
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-cpp-rules;
  };
}
