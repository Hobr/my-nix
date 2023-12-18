{
  users.users = {
    hobr = {
      isNormalUser = true;
      extraGroups = [ "wheel", "networkmanager","audio" "plugdev" "input" "systemd-journal" "video" "power" "nix" ];
    };
  };
}
