pkgs: {
  trellis = pkgs.callPackage ./trellis { };
  dirhash = pkgs.python3Packages.callPackage ./dirhash { };
  harbor = pkgs.python3Packages.callPackage ./harbor {
    dirhash = pkgs.python3Packages.callPackage ./dirhash { };
  };
}
