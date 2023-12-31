{ inputs, ... }:
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

    # 主题
    ./desktop/theme.nix
    # Hyprland
    ./desktop/hyprland.nix
    # 终端
    ./desktop/terminal.nix
    # Waybar
    ./desktop/bar.nix
    # Rofi
    ./desktop/rofi.nix

    # ZSH
    ./terminal/zsh.nix
    # GNU
    ./terminal/gnu.nix
    # 工具
    ./terminal/tool.nix
    # 工具(单独)
    ./terminal/cli.nix
    # DirEnv
    ./terminal/direnv.nix

    # 输入法
    ./software/fcitx.nix
    # 浏览器
    ./software/firefox.nix
    # 视频
    ./software/video.nix
    # 音频
    ./software/audio.nix
    # VSCode
    ./software/vscode.nix
    # NeoVim
    ./software/nvim.nix
    # Emacs
    ./software/emacs.nix
    # 下载
    ./software/download.nix
    # OBS
    ./software/obsstudio.nix

    # TexInfo
    ./office/texinfo.nix

    # Python
    ./sci/python.nix
    # 科学制图
    ./sci/plot.nix
  ];
}
