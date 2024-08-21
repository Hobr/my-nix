{ inputs, outputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.chaotic.nixosModules.default
    inputs.impermanence.nixosModules.impermanence
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.hyprland.nixosModules.default
    inputs.solaar.nixosModules.default

    outputs.nixosModules

    # Shell
    ./tool/shell.nix
    # 安全
    ./tool/secure.nix
    # 代理
    ./tool/proxy.nix
    # 虚拟化
    ./tool/virt.nix
    # Steam
    ./tool/steam.nix
  ];

  sys = {
    config = {
      nix.enable = true;
      kernel.enable = true;
      locale.enable = true;
    };

    disk = {
      persist.enable = true;
      snapper.enable = true;
    };

    boot = {
      systemd-boot.enable = true;
      secure-boot.enable = true;
      tpm.enable = true;
    };

    system = {
      driver.enable = true;
      network.enable = true;
      audio.enable = true;
      bluetooth.enable = true;
    };

    desk = {
      hyprland.enable = true;
    };

    program = {
      docker.enable = true;
      ld.enable = true;
      nh.enable = true;
    };
  };
}
