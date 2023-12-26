{
  imports = [
    # Nix配置
    ./nix.nix
    # 全局配置
    ./config.nix

    # 浏览器
    ./firefox.nix
    # VSCode
    ./vscode.nix

    # 终端工具
    ./cli.nix
    # Btop
    ./btop.nix

    # Git
    ./git.nix
    # GPG
    ./gpg.nix
    # SSH
    ./ssh.nix

    # NeoVim
    ./nvim.nix
  ];
}
