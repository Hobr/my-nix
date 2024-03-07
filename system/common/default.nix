{
  imports = [
    ./config/platform.nix
    ./config/nix.nix

    ./system/boot.nix
    ./system/kernel.nix
    ./system/secureboot.nix
    ./system/tpm.nix
    ./system/impermanence.nix
    ./system/launcher.nix

    ./hardware/audio.nix
    ./hardware/bluetooth.nix
    ./hardware/network.nix
    ./hardware/hardware.nix

    ./user/locale.nix
    ./user/secure.nix

    ./tool/nh.nix
    ./tool/openssh.nix
    ./tool/proxy.nix
  ];
}
