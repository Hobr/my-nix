{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    hyprpicker
    slurp
    grim
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast

    gimp
    swappy
    inkscape
  ];
}
