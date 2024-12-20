{
  inputs,
  ...
}:
{
  additions = final: prev: import ../pkg final.pkgs;

  modifications = final: prev: {
  };

  small-package = final: _prev: {
    small = import inputs.nixpkgs-small {
      system = final.system;
      config.allowUnfree = true;
      config.cudaSupport = true;
    };
  };
}
