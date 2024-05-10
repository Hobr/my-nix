{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    telegram-desktop
    fractal
    inputs.lyf.packages.${pkgs.system}.wemeet
    (qq.override (old: {
      # Wayland Fcitx5
      commandLineArgs = (old.commandLineArgs or [ ]) ++ [ "--enable-wayland-ime" ];
    }))
  ];
}
