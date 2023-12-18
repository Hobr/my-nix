# UmiPro3 系统入口
{
  imports = [
    ../common
  ];

  networking = {
    hostName = "handsonic";
    useDHCP = true;
  };

  i18n.defaultLocale = "zh_CN.UTF-8";

  boot.loader.systemd-boot.enable = true;

  users.users = {
    kanade = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  nixpkgs.hostPlatform = "x86_64-linux";
}
