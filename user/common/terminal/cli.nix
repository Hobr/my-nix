{ pkgs, ... }: {
  home.packages = with pkgs; [
    nano
    nixfmt
    nixpkgs-review

    wget
    axel
    httpie

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

    # arduino
    # arduino-ide

    # 屏幕键盘
    squeekboard
  ];

  programs.info.enable = true;
}
