{ inputs, ... }:
{
  imports = [
    inputs.impermanence.home-manager.impermanence
  ];

  home.persistence."/persist/home/hobr" = {
    directories = [
      "Document"
      "Download"
      "Picture"
      "Music"
      "Video"
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
