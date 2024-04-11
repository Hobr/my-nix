{pkgs, ...}: {
  home.packages = with pkgs.unstable; [
    nano
    nixfmt

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
  ];

  programs.info.enable = true;
}
