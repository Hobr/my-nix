pkgs: {
  trellis = pkgs.callPackage ./trellis { };
  harbor = pkgs.callPackage ./harbor { };
}
