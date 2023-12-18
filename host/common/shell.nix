{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.zsh-powerlevel10k
  ];

  programs.zsh = {
    enable = true;

    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

    ohMyZsh = {
      enable = true;
      plugins = [ "git" "python" "man" ];
      theme = "agnoster";
    };
  };

  users.defaultUserShell = pkgs.zsh;
}
