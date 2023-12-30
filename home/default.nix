{inputs,...}:
{
  imports = [
    #inputs.hyprland.homeManagerModules.default 

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

    # Hyprland
    ./desktop/hyprland.nix
    # 主题
    ./desktop/theme.nix
    # 终端
    ./desktop/alacritty.nix
    # Waybar
    # Rofi

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
