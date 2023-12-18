# My NixOS

个人的**NixOS**配置, 日常生活使用, 更新频率较高

## 介绍

- 主机
  - handsonic 笔记本: 机械革命 Umi Pro 3, Intel i7-11800H, RTX3060, 32G
  - distortion 服务器: 4H4G, 40G, 150Mbps, 美国

## 安装

```bash
sudo -i

# 部署
nixos-generate-config --root /mnt
git clone https://github.com/Hobr/my-nix.git
cd my-nix

nano /mnt/etc/nixos/hardware-configuration.nix
rm /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/configuration.nix

# 代理
export all_proxy=http://192.168.1.102:10809
echo -n "password" > /tmp/secret.key
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko host/common/disko.nix --arg disks '[ "/dev/nvme0n1" ]'
lsblk -f
nixos-install --show-trace --flake .#handsonic
reboot

sudo passwd -l root
nix shell nixpkgs#home-manager
home-manager switch --flake .#kanade@handsonic --show-trace
reboot
make switch
```

## 参考资料

- [NixOS Wiki](https://nixos.wiki/)
- [Misterio77/nix-starter-configs](https://github.com/Misterio77/nix-starter-configs)
- [ryan4yin/nix-config](https://github.com/ryan4yin/nix-config)
