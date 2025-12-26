{
  inputs,
  ...
}:
{
  additions = final: prev: import ../pkg final.pkgs;

  modifications = final: prev: {
    pythonPackagesExtensions = (prev.pythonPackagesExtensions or [ ]) ++ [
      (python-final: python-prev: {
        whisperx = python-prev.whisperx.overridePythonAttrs (old: {
          patches = (old.patches or [ ]) ++ [
            ./whisperx.patch
          ];

          propagatedBuildInputs = (old.propagatedBuildInputs or [ ]) ++ [
            python-final.omegaconf
          ];
        });
      })
    ];
  };

  stable-package = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.stdenv.hostPlatform.system;
      config = {
        # 非自由软件
        allowUnfree = true;
        # 破损软件
        allowBroken = true;
      };
    };
  };
}
