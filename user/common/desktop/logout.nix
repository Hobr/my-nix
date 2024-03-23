{pkgs, ...}: {
  programs.wlogout = {
    enable = true;
    package = pkgs.unstable.wlogout;
    layout = [];
    style = "";
  };
}
