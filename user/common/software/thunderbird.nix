{ pkgs, ... }: {
  programs.thunderbird = {
    enable = true;
    package = pkgs.unstable.thunderbird;
    profiles.hobr = { isDefault = true; };
    settings = { };
  };
}
