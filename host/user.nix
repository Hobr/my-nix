{
  users.users = {
    kanade = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
      extraGroups = ["wheel" "networkmanager"];
    };
  };
}
