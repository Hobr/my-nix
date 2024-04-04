{outputs, ...}: {
  nixpkgs = {
    # Overlays
    overlays = [
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];

    # 配置
    config.allowUnfree = true;
  };

  # 文档
  manual = {
    manpages.enable = false;
    html.enable = false;
    json.enable = false;
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";
}
