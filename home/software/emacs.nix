{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [ epkgs.emms epkgs.magit ];
    extraConfig = { };
  };
}
