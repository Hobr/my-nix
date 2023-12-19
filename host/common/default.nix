{ outputs, lib, config, modulesPath, ... }: {
  imports = [
    # 硬件
    (modulesPath + "/installer/scan/not-detected.nix")

    # Nix配置
    ./nix.nix
    # 用户
    ./user.nix

    # 权限
    ./permissions.nix
    # TPM2
    ./tpm.nix
    # 安全启动
    ./secureboot.nix
    # ZSH
    ./shell.nix
    # GnuPG
    ./gnupg.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  environment.etc =
    lib.mapAttrs'
      (name: value: {
        name = "nix/path/${name}";
        value.source = value.flake;
      })
      config.nix.registry;

  programs.ccache.enable = true;
  system.stateVersion = "23.11";
}
