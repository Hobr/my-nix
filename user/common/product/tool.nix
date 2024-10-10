{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # 编辑器
    nano
    # 虚拟机
    virt-manager
    # 开发
    gitkraken
    postman
    # 二进制
    ghex
    imhex
    # Nix
    nurl
    nix-init
    nix-update
    nixfmt-rfc-style
    nixpkgs-review
    prefetch-npm-deps
  ];
}
