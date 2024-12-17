{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # 虚拟机
    virt-manager
    # 开发
    hoppscotch
    # 二进制
    ghex
    # Nix
    nurl
    nix-init
    nix-update
    nixfmt-rfc-style
    nixpkgs-review
  ];
}
