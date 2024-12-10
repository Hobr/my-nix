pkgs: {
  aegisub = pkgs.callPackage ./aegisub { };
  rime-ice = pkgs.callPackage ./rime-ice { };

  intel-fortran = pkgs.callPackage ./intel-fortran.nix { };
  nv-fortran = pkgs.callPackage ./nv-fortran.nix { };
}
