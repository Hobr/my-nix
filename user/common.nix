{
  inputs,
  outputs,
  ...
}:
{
  imports = [
    inputs.stylix.homeManagerModules.stylix

    outputs.homeManagerModules
  ];

  home = {
    # 系统版本号
    stateVersion = "25.05";

    desktop = {
      hypr.enable = true;
      waybar.enable = true;
      menu.enable = true;
      ime.enable = true;

      tool = {
        clipboard = true;
        notice = true;
        xdg = true;
        pointer = true;
        theme = true;
      };

      secure = {
        lock = true;
        logout = true;
      };
    };

    web = {
      browser.enable = true;
      im.enable = true;
      mail.enable = true;
      music.enable = true;
      download.enable = true;
      sync.enable = true;
    };

    software = {
      docs.enable = true;
      terminal.enable = true;
      zsh.enable = true;
    };

    media = {
      audio.enable = true;
      video.enable = true;
      image.enable = true;
    };

    dev = {
      git.enable = true;
      gpg.enable = true;
      nix.enable = true;
      direnv.enable = true;
      util.enable = true;

      editor = {
        vscode = true;
        nvim = true;
        emacs = true;
        qt = true;
      };
    };

    util = {
      audio.enable = true;
      gnu.enable = true;
      ssh.enable = true;
      disk.enable = true;
      file.enable = true;
      cli.enable = true;
    };
  };
}
