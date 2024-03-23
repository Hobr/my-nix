{pkgs, ...}: {
  programs.direnv = {
    enable = true;
    package = pkgs.unstable.direnv;
    enableZshIntegration = true;
    nix-direnv = {
      enable = true;
      package = pkgs.unstable.nix-direnv;
    };
    config = {};
  };
}
