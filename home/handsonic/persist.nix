{ inputs, ... }:
{
  imports = [
    inputs.impermanence.home-manager.impermanence
  ];

  home.persistence."/persistent/home/hobr" = {
    directories = [
      "Download"
      "Picture"
      "Document"
      ".ssh"
      ".config"
      ".gnupg"
      ".local/share"
    ];
    files = [
    ];
    allowOther = true;
  };
}
