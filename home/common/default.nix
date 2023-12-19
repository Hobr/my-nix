{ outputs, ... }: {
  imports = [
    # 用户
    ./user.nix
    # 开发环境
    ./direnv.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;
  home.stateVersion = "23.11";
  systemd.user.startServices = "sd-switch";
}
