{ pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.unstable.emacs;

    extraPackages = epkgs: [ epkgs.catppuccin-theme epkgs.magit ];

    extraConfig = ''
      (load-theme 'catppuccin :no-confirm)
      (setq catppuccin-flavor 'latte) ;;
      (catppuccin-reload)
    '';
  };
}
