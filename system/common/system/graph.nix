{ pkgs, ... }:
{
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;

  # XDG
  xdg.portal.enable = true;

  environment.systemPackages = [ pkgs.xdg-utils ];

}
