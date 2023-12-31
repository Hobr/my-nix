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

  # 文档
  manual = {
    manpages.enable = true;
    html.enable = false;
    json.enable = false;
  };

  systemd.user.startServices = "sd-switch";
}
