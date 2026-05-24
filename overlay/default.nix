{
  inputs,
  ...
}:
{
  additions = final: prev: import ../pkg final.pkgs;

  modifications = final: prev: {
    # 临时应用 https://github.com/NixOS/nixpkgs/pull/522705
    # 修复 python3.13-jedi-language-server 与 jedi 0.20.0 不兼容导致的构建失败
    # 影响 vscode-extension-ms-python-python 的安装
    python313 = prev.python313.override (old: {
      packageOverrides = prev.lib.composeExtensions (old.packageOverrides or (_: _: { })) (
        pyfinal: pyprev: {
          jedi-language-server = pyprev.jedi-language-server.overrideAttrs (oldAttrs: {
            pythonRelaxDeps = (oldAttrs.pythonRelaxDeps or [ ]) ++ [ "jedi" ];
          });
        }
      );
    });

    linuxPackages = final.pkgs.linuxPackages_latest;
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
