{ inputs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.chaotic.nixosModules.default
    inputs.impermanence.nixosModules.impermanence
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.nh.nixosModules.default

    # 软件
    ./system/nix.nix
    # 引导
    ./system/boot.nix
    # 内核
    ./system/kernel.nix
    # 安全启动
    ./system/secureboot.nix
    # TPM
    ./system/tpm.nix
    # 无状态
    ./system/impermanence.nix
    # 图形环境
    ./system/graph.nix

    # 音频
    ./hardware/audio.nix
    # 蓝牙
    ./hardware/bluetooth.nix
    # 网络
    ./hardware/network.nix
    # 硬件
    ./hardware/hardware.nix

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
  ];
}
