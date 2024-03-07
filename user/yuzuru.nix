{ outputs, ... }:
{
  imports = [
    ./common
    ./yuzuru
  ];

  nixpkgs = {
    # Overlays
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];

    # 配置
    config.allowUnfree = true;
  };

  home = {
    username = "yuzuru";
    homeDirectory = "/home/yuzuru";
    stateVersion = "23.11";
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
