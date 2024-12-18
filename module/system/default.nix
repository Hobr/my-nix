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
    };

    # Overlays
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      inputs.nix-xilinx.overlay
    ];
  };
}
