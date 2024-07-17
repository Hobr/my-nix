{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.magit
    ];
  };
}
