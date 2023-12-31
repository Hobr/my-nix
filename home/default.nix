{ inputs, ... }:
{
  imports = [
    inputs.nix-index-database.hmModules.nix-index

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
    # 同步
    ./tool/sync.nix
    # 存储
    ./tool/disk.nix

    # 主题
    ./desktop/theme.nix
    # Hyprland
    ./desktop/hyprland.nix
    # 终端
    ./desktop/terminal.nix
    # Waybar
    ./desktop/wabar.nix
    # Rofi
    ./desktop/rofi.nix
    # 消息
    ./desktop/notice.nix
    # 锁屏
    ./desktop/lock.nix
    # 剪切板
    ./desktop/clipboard.nix
    # 注销菜单
    ./desktop/logout.nix

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

    # 基础软件
    ./software/base.nix
    # 输入法
    ./software/fcitx.nix
    # 浏览器
    ./software/firefox.nix
    # 视频
    ./software/video.nix
    # 音频
    ./software/audio.nix
    # 图片
    ./software/image.nix
    # 即时通讯
    ./software/im.nix
    # 邮箱
    ./software/thunderbird.nix
    # 下载
    ./software/download.nix
    # VSCode
    ./software/vscode.nix
    # NeoVim
    ./software/nvim.nix
    # OBS
    ./software/obsstudio.nix

    # TexInfo
    ./office/texinfo.nix

    # Python
    ./study/python.nix
    # 数学
    ./study/math.nix
    # 阅读
    ./study/reader.nix
    # 写作
    ./study/writer.nix
    # Tex
    ./study/tex.nix
  ];
}
