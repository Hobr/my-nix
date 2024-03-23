{outputs, ...}: {
  imports = [
    ./common
    ./config/kanade
  ];

  home = {
    username = "kanade";
    homeDirectory = "/home/kanade";
    stateVersion = "23.11";
  };
}
