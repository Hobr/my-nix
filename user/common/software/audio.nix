{ pkgs, ... }:
{
  # MPD
  services.mpd = {
    enable = true;
    extraConfig = "";
  };

  # MPD歌词
  services.mpd-mpris = {
    enable = true;
    mpd.useLocal = true;
  };

  # MPD客户端
  programs.ncmpcpp = {
    enable = true;
    bindings = [ ];
    settings = { };
  };

  home.packages = with pkgs; [
    # 音乐播放器
    amberol
    # 音频编辑
    audacity
  ];
}
