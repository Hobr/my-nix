{pkgs, ...}: {
  rime-ice = pkgs.callPackage ./rime-ice.nix {};
  aegisub = pkgs.callPackage ./aegisub.nix {};
}
