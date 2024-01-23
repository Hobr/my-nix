{ pkgs, ... }:
{
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.unstable.zsh;
  environment.pathsToLink = [ "/share/zsh" ];
}
