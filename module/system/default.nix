{
  inputs,
  outputs,
  ...
}:
{
  imports = [
    ./boot
    ./config
    ./desk
    ./disk
    ./gpu
    ./io
    ./program
  ];

  nixpkgs = {
    config = {
      # 非自由软件
      allowUnfree = true;
      # 跨平台
      allowUnsupportedSystem = true;
      # 破损软件
      allowBroken = true;
    };

    # Overlays
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-package

      inputs.nix-xilinx.overlay
    ];
  };
}
