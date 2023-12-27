{
  imports = [
    # Nix配置
    ./global/nix.nix
    # 全局配置
    ./global/config.nix

    # GPG
    ./tool/gpg.nix
    # SSH
    ./tool/ssh.nix
    # Git
    ./tool/git.nix

    # XDG
    ./user/xdg.nix

    # ZSH
    ./terminal/zsh.nix
    # 终端工具
    ./terminal/cli.nix
    # Btop
    ./terminal/btop.nix
    # DirEnv
    ./terminal/direnv.nix

    # 浏览器
    ./software/firefox.nix
    # VSCode
    ./software/vscode.nix
    # NeoVim
    ./software/nvim.nix
  ];
}
