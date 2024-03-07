{
  imports = [
    ./host/platform.nix
    ./host/nix.nix

    ./system/boot.nix
    ./system/impermanence.nix
    ./system/kernel.nix
    ./system/launcher.nix
    ./system/secureboot.nix
    ./system/tpm.nix
  ];
}
