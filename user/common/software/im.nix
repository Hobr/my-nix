{ pkgs, ... }: {
  home.packages = with pkgs; [ qq telegram-desktop element-desktop ];
}
