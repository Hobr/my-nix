{outputs, ...}: {
  imports = [
    ./common
    ./config/yuzuru
  ];

  home = {
    username = "yuzuru";
    homeDirectory = "/home/yuzuru";
    stateVersion = "23.11";
  };
}
