{pkgs, ...}: {
  aegisub-arch1t3cht = pkgs.callPackage ./aegisub.nix {};
  rime-ice = pkgs.callPackage ./rime-ice.nix {};
}
