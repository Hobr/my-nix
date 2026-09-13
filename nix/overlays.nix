{ inputs, ... }:
{
  modifications = final: _prev: {
    linuxPackages = final.pkgs.linuxPackages_latest;
  };

  stable-package = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.stdenv.hostPlatform.system;
      config = {
        allowUnfree = true;
        allowBroken = true;
      };
    };
  };
}
