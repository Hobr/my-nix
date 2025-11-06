{
  inputs,
  ...
}:
{
  additions = final: prev: import ../pkg final.pkgs;

  modifications = final: prev: {
  };

  stable-package = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.stdenv.hostPlatform.system;
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
