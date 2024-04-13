{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [ epkgs.catppuccin-theme epkgs.magit ];

    extraConfig = ''
      (load-theme 'catppuccin :no-confirm)
      (setq catppuccin-flavor 'latte) ;;
      (catppuccin-reload)
    '';
  };
}
