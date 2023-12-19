{
  nixpkgs = {
    hostPlatform = {
      gcc.arch = "tigerlake";
      gcc.tune = "tigerlake";
      system = "x86_64-linux";
    };
  };
}
