{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs.unstable; [
    hyprpicker
    slurp
    grim
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast

    gimp
    swappy
    inkscape
  ];
}
