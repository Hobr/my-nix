{ inputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager
  ];
  home.persistence."/persist/home/hobr" = {
    allowOther = true;
    directories = [
      "Download"
      "Music"
      "Docs"
      "Picture"

      ".ssh"
      ".gnupg"
      ".vscode"

      ".config"
      ".mozilla"


      ".local/share"
      ".cache"
    ];
  };
}
