# Server user profile - minimal configuration without desktop environment
{
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  imports = [
    ./base.nix
  ];

  home = {
    proxy.enable = true;

    # 服务器不需要桌面环境
    # desktop = { ... } 不启用

    # 仅基础 web 工具
    web = {
      browser.enable = false;  # 服务器通常不需要图形浏览器
      im.enable = false;
      mail.enable = false;
      music.enable = false;
      download.enable = true;  # 可能需要下载工具
      sync.enable = false;
    };

    software = {
      docs.enable = false;  # 服务器不需要文档查看器
    };

    # 不需要媒体工具
    media = {
      audio.enable = false;
      video.enable = false;
      image.enable = false;
    };

    dev = {
      editor = {
        vscode = false;  # 服务器使用命令行编辑器
        nvim = true;
        emacs = false;
      };
    };

    # 不需要专业软件
    pro = {
      audio.enable = false;
      video.enable = false;
      image.enable = false;
      obs.enable = false;
      electron.enable = false;
    };
  };

  # 服务器不需要主题配置
}