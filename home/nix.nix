{outputs,...}:
{
  nixpkgs = {
    # Overlays
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];

    # 配置
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
}
