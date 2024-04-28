{ pkgs, ... }: {
  home.packages = with pkgs; [
    wget
    axel
    httpx
    iftop

    nitch
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
  ];

  programs.info.enable = true;
}
