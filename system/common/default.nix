{ inputs, outputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.chaotic.nixosModules.default
    inputs.impermanence.nixosModules.impermanence
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.hyprland.nixosModules.default
    inputs.sops-nix.nixosModules.sops
    inputs.solaar.nixosModules.default

    outputs.nixosModules

    # 软件
    ./system/nix.nix
    # 内核
    ./system/kernel.nix
    # TPM
    ./system/tpm.nix
    # 图形环境
    ./system/graph.nix

    # 语言
    ./tool/locale.nix
    # 硬盘
    ./tool/disk.nix
    # Shell
    ./tool/shell.nix
    # 安全
    ./tool/secure.nix
    # 代理
    ./tool/proxy.nix
    # NH
    ./tool/nh.nix
    # 虚拟化
    ./tool/virt.nix
    # Docker
    ./tool/docker.nix
    # Nix LD
    ./tool/ld.nix
    # Steam
    ./tool/steam.nix
  ];

  system = {
    driver.enable = true;
    network.enable = true;
    audio.enable = true;
    bluetooth.enable = true;
  };

  boot = {
    systemd-boot.enable = true;
    secure-boot.enable = true;
    persist.enable = true;
  };
}
