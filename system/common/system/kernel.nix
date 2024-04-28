{ pkgs, ... }: {
  # 内核
  boot = {
    # 版本
    kernelPackages = pkgs.linuxPackages_cachyos;

    # 内核参数
    kernelParams = [ "systemd.gpt_auto=0" ];
  };

  # scx
  chaotic.scx = {
    enable = true;
    scheduler = "scx_rusty";
  };

  # Ananicy
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-cpp-rules;
  };
}
