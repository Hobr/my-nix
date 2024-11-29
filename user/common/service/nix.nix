{ inputs, outputs, ... }:
{
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

  # 文档
  manual = {
    manpages.enable = false;
    html.enable = false;
    json.enable = false;
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";
}
