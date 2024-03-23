{pkgs, ...}: {
  # Aria
  programs.aria2 = {
    enable = true;
  };

  home.packages = with pkgs.unstable; [
    transmission_4-gtk
  ];
}
