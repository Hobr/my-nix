{
  # MPD
  services.mpd = {
    enable = true;
    extraConfig = "";
  };

  # Playctl
  services.playerctld.enable = true;

  # MPD歌词
  services.mpd-mpris = {
    enable = true;
    mpd.useLocal = true;
  };

  # MPD客户端
  programs.ncmpcpp = {
    enable = true;
    bindings = [ ];
    mpdMusicDir = "/home/kanade/Music";
    settings = { };
  };
}
