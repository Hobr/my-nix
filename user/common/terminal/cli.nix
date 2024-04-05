{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs.unstable; [
    nano
    nixpkgs-fmt

    wget
    httpie

    fastfetch
    xorg.xlsclients
    xorg.xset

    brightnessctl
    trash-cli

    sd
    ranger
    dialog

    p7zip
    zip
    unzip

    arduino
    arduino-ide

    inputs.alejandra.defaultPackage.${system}
    nix-init
    cachix
  ];

  programs.info.enable = true;
}
