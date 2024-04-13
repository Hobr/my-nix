{ pkgs, ... }: {
  programs.thunderbird = {
    enable = true;
    profiles.hobr = { isDefault = true; };
    settings = { };
  };
}
