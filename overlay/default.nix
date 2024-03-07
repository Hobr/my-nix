{ inputs, ... }: {
  additions = final: _prev: import ../pkg { pkgs = final; };

  modifications = final: prev: { };

  # pkgs.unstable
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [ "electron-25.9.0" ];
      };
    };
  };
}
