{inputs, ...}: {
  imports = [
    inputs.hyprland.homeManagerModules.default

    # Nix
    ./tool/nix.nix
    # 硬盘
    ./tool/disk.nix
    # Git
    ./tool/git.nix
    # GPG
    ./tool/gpg.nix
    # SSH
    ./tool/ssh.nix
    # 同步
    ./tool/sync.nix

    # 桌面
    ./desktop/hypr.nix
    # 任务栏
    ./desktop/waybar.nix
    # 锁屏
    ./desktop/lock.nix
    # 注销
    ./desktop/logout.nix
    # 启动器
    ./desktop/rofi.nix
    # 消息
    ./desktop/notice.nix
    # 终端
    ./desktop/terminal.nix
    # 剪切板
    ./desktop/clipboard.nix
    # 主题
    ./desktop/theme.nix

    # 音频
    ./software/audio.nix
    # 视频
    ./software/video.nix
    # 图像
    ./software/image.nix

    # 浏览器
    ./software/firefox.nix
    # 邮箱
    ./software/thunderbird.nix
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

    # NeoVim
    ./software/nvim.nix
    # Emacs
    ./software/emacs.nix
    # VS Code
    ./software/vscode.nix
    # QT
    ./software/qt.nix

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

    # 阅读
    ./study/reader.nix
    # 编辑
    ./study/writer.nix
    # Tex
    ./study/tex.nix
    # 数学
    ./study/math.nix
  ];
}
