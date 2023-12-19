{ inputs, lib, config, ... }: {

  nix = {
    nixPath = [ "/etc/nix/path" ];
    registry = (lib.mapAttrs (_: flake: { inherit flake; })) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      extra-sandbox-paths = [ config.programs.ccache.cacheDir ];
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 3d";
    };
  };

  documentation = {
    man.enable = true;
    doc.enable = false;
    dev.enable = false;
    info.enable = false;
  };
}
