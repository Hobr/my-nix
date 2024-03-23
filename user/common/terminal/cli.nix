{ pkgs, inputs, ... }:
{
  home.packages = with pkgs.unstable; [
    nano
    nixpkgs-fmt

    wget
    httpie

    fastfetch
    xorg.xlsclients

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
  ];

  programs.info.enable = true;
}
