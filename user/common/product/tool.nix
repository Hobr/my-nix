{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # 编辑器
    nano
    # 虚拟机
    virt-manager
    # 开发
    gitkraken
    # 二进制
    ghex
    imhex
    # API测试
    # bruno
    # Nix
    nurl
    nix-init
    nixfmt-rfc-style
    nixpkgs-review
    prefetch-npm-deps
  ];
}
