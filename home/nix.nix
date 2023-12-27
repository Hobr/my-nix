{ outputs, ... }:
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
    };
  };

  systemd.user.startServices = "sd-switch";
}
