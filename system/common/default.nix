{
  imports = [
    ./host/platform.nix
    ./host/nix.nix

    ./system/boot.nix
    ./system/kernel.nix
    ./system/secureboot.nix
    ./system/tpm.nix
    ./system/impermanence.nix
    ./system/launcher.nix

    ./tool/nh.nix
    ./tool/openssh.nix
    ./tool/proxy.nix
  ];
}
