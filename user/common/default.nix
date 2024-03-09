{
  imports = [
    # 剪切板
    ./desktop/clipboard.nix
    # 桌面
    ./desktop/hypr.nix
    # 锁屏
    ./desktop/lock.nix
    # 注销
    ./desktop/logout.nix
    # 消息
    ./desktop/notice.nix
    # 启动器
    ./desktop/rofi.nix
    # 终端
    ./desktop/terminal.nix
    # 主题
    ./desktop/theme.nix
    # 任务栏
    ./desktop/waybar.nix

    # 音频
    ./software/audio.nix
    # 下载
    ./software/download.nix
    # 输入法
    ./software/fcitx.nix
    # 浏览器
    ./software/firefox.nix
    # 即时通讯
    ./software/im.nix
    # 图像
    ./software/image.nix
    # 管理
    ./software/manage.nix
    # NeoVim
    ./software/nvim.nix
    # OBS-Studio
    ./software/obs.nix
    # 邮箱
    ./software/thunderbird.nix
    # 视频
    ./software/video.nix
    # VS Code
    ./software/vscode.nix

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

    # CLI
    ./terminal/cli.nix
    # 
    ./terminal/direnv.nix
    # GNU
    ./terminal/gnu.nix
    # 工具
    ./terminal/tool.nix
    # ZSH
    ./terminal/zsh.nix

    # 数学
    ./study/math.nix
    # 阅读
    ./study/reader.nix
    # 
    ./study/tex.nix
    # 编辑
    ./study/writer.nix
  ];
}
