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
      config = {
        # 非自由软件
        allowUnfree = true;
        # 跨平台
        allowUnsupportedSystem = true;
        # 破损软件
        allowBroken = true;
      };
    };
  };
}
