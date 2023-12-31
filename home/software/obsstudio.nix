{pkgs,...}:
{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [ wlrobs obs-vaapi obs-pipewire-audio-capture obs-multi-rtmp ];
  };
}
