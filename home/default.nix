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
    ./desktop/alacritty.nix
    # Waybar
    ./desktop/waybar.nix
    # Rofi
    ./desktop/rofi.nix

    # ZSH
    ./terminal/zsh.nix
    # GNU
    ./terminal/gnu.nix
    # 工具
    ./terminal/cli.nix
    # Btop
    ./terminal/btop.nix
    # DirEnv
    ./terminal/direnv.nix

    # 浏览器
    ./software/firefox.nix
    # VSCode
    ./software/vscode.nix
    # NeoVim
    ./software/nvim.nix
  ];
}
