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
      # 破损软件
      allowBroken = true;
      # 漏洞软件
      permittedInsecurePackages = [ ];
    };

    # Overlays
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-package
    ];
  };
}
