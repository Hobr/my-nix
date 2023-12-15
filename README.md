# My NixOS

个人的 ***NixOS***配置, 日常生活中在用, 更新频率较高

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
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko system/disko.nix --arg disks '[ "/dev/nvme0n1" ]'
lsblk -f
nixos-install --show-trace --flake .#hobr-nixos
reboot

sudo passwd -l root
nix shell nixpkgs#home-manager
home-manager switch --flake .#hobr@hobr-nixos --show-trace
reboot
make switch
```

## 参考资料

- [NixOS Wiki](https://nixos.wiki/)
- [Misterio77/nix-starter-configs](https://github.com/Misterio77/nix-starter-configs)
- [ryan4yin/nix-config](https://github.com/ryan4yin/nix-config)
