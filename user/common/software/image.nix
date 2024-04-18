{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    hyprpicker
    slurp
    grim
    inputs.hyprcontrib.packages.${pkgs.system}.grimblast

    gimp
    swappy
    inkscape
  ];
}
