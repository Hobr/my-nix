{ inputs, ... }:
{
  additions = final: prev: import ../pkg final.pkgs;

  modifications =
    final: prev:
    {
    };

  stable-package = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
      config.cudaSupport = true;
    };
  };
}
