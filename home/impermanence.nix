{ inputs, ... }:
{
  imports = [
    inputs.impermanence.home-manager.impermanence
  ];

  home.persistence."/persist/home/kanade" = {
    allowOther = true;
    directories = [
      # XDG
      "Desktop"
      "Download"
      "Document"
      "Picture"
      "Video"
      "Music"
      ".local/share"

      # CLI
      ".ssh"
      ".gnupg"

      # 配置文件
      ".config"
    ];
    files = [ ];
  };
}
