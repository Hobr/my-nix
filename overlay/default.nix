{
  inputs,
  ...
}:
{
  additions = final: prev: import ../pkg final.pkgs;

  modifications = final: prev: {
    vscode-utils = prev.vscode-utils // {
      buildVscodeMarketplaceExtension =
        args:
        prev.vscode-utils.buildVscodeMarketplaceExtension (
          args
          // {
            nativeBuildInputs = (args.nativeBuildInputs or [ ]) ++ [ prev.unzip ];
          }
        );
    };
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
