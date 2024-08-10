{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    telegram-desktop
    discord
    (qq.override (old: {
      # Wayland Fcitx5
      commandLineArgs = (old.commandLineArgs or [ ]) ++ [ "--enable-wayland-ime" ];
    }))
  ];
}
