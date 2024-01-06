{ inputs, ... }: {
  additions = final: _prev: import ../pkg { pkgs = final; };

  modifications = final: prev: {
    # VS Code Fcitx5
    vscode = prev.vscode.override (old: {
      commandLineArgs = (old.commandLineArgs or [ ]) ++ [ "--enable-wayland-ime" "-g" ];
    });
  };

  # pkgs.unstable
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
