{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # 编辑器
    nano
    # 开发
    cookiecutter
    pre-commit
    # 二进制
    # cutter
    gnome.ghex
    # API测试
    # bruno
    # Nix
    nurl
    nix-init
    nixfmt-rfc-style
    nixpkgs-review
  ];
}
