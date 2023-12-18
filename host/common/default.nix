{ outputs, lib, config, modulesPath, ... }: {
  imports = [
    # 硬件
    (modulesPath + "/installer/scan/not-detected.nix")

    # Nix配置
    ./nix.nix
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

  system.stateVersion = "23.11";
}
