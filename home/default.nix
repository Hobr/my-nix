{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # Nix配置
    ./nix.nix
    # Home-Manager 配置
    ./home.nix

    # Git
    ./git.nix
    # NeoVim
    ./nvim.nix

    # 终端工具
    ./cli.nix
  ];
}
