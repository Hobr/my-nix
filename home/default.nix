{
  imports = [
    # Nix配置
    ./nix.nix
    # 全局配置
    ./config.nix


    # GPG
    ./gpg.nix
    # SSH
    ./ssh.nix
    # Git
    ./git.nix

    # XDG
    ./xdg.nix

    # ZSH
    ./zsh.nix
    # 终端工具
    ./cli.nix
    # Btop
    ./btop.nix

    # 浏览器
    ./firefox.nix
    # VSCode
    ./vscode.nix
    # NeoVim
    ./nvim.nix
  ];
}
