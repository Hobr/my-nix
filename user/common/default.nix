{ inputs, ... }:
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    inputs.catppuccin.homeManagerModules.catppuccin

    # Nix
    ./service/nix.nix
    # 硬盘
    ./service/disk.nix
    # Git
    ./service/git.nix
    # GPG
    ./service/gpg.nix
    # SSH
    ./service/ssh.nix
    # 同步
    ./service/sync.nix

    # 主题
    ./desktop/theme.nix

    # 音频
    ./software/audio.nix
    # 视频
    ./software/video.nix
    # 图像
    ./software/image.nix

    # 网络
    ./software/internet.nix
    # 邮箱
    ./software/mail.nix
    # 即时通讯
    ./software/im.nix

    # 下载
    ./software/download.nix
    # 管理
    ./software/manage.nix
    # 输入法
    ./software/fcitx.nix
    # OBS-Studio
    ./software/obs.nix

    # CLI
    ./terminal/cli.nix
    # 工具
    ./terminal/tool.nix
    # ZSH
    ./terminal/zsh.nix
    # Starship
    ./terminal/starship.nix
    # GNU
    ./terminal/gnu.nix
    # 开发环境
    ./terminal/direnv.nix

    # 文档
    ./product/docs.nix
    # NeoVim
    ./product/nvim.nix
    # Emacs
    ./product/emacs.nix
    # VS Code
    ./product/vscode.nix
    # QT
    ./product/qt.nix
    # 电路
    ./product/electron.nix
    # 其他工具
    ./product/tool.nix
  ];
}
