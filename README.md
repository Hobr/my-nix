# My NixOS

个人的**NixOS**配置, 日常生活使用, 更新频率较高

## 介绍

- 主机
  - handsonic 笔记本: 机械革命 Umi Pro 3, Intel i7-11800H, RTX3060, 32G

- 用户
  - kanade: 个人

## TODO

- Rime
- ZSH Bindkey
- 桌面环境
- VSCode环境
- ReGreet
- NVim环境
- Systemd-timesyncd resolved....
- CCache
- 邮箱

## 安装

```bash
sudo -i

# 分区
parted /dev/nvme0n1 mklabel gpt

# LUKS
cryptsetup luksFormat /dev/nvme0n1
cryptsetup luksOpen /dev/nvme0n1 crypt

# LVM
pvcreate /dev/mapper/crypt
vgcreate system /dev/mapper/crypt

lvcreate -L 24G system -n swap
lvcreate -l 100%FREE system -n root

# Btrfs
mkfs.btrfs -L NixOS /dev/mapper/system-root
mount -m /dev/mapper/system-root /mnt
btrfs subvolume create /mnt/@nix
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@persist
btrfs subvolume list /mnt
umount /mnt

# 挂载
mount -t tmpfs none /mnt
mount -m -t btrfs -o defaults,ssd,discard,noatime,space_cache=v2,compress=zstd,subvol=@nix /dev/mapper/system-root /mnt/nix
mount -m -t btrfs -o defaults,ssd,discard,noatime,space_cache=v2,compress=zstd,subvol=@home /dev/mapper/system-root /mnt/home
mount -m -t btrfs -o defaults,ssd,discard,noatime,space_cache=v2,compress=zstd,subvol=@persist /dev/mapper/system-root /mnt/persist

mount -m /dev/nvme1n1p1 /mnt/boot
mount -m /dev/nvme1n1p3 /mnt/mnt/windows
mount -m /dev/nvme1n1p4 /mnt/mnt/data

# Snapper
btrfs subvolume create /mnt/nix/.snapshots
btrfs subvolume create /mnt/home/.snapshots
btrfs subvolume create /mnt/persist/.snapshots


# 交换
mkswap -L Swap /dev/mapper/system-swap
swapon /dev/mapper/system-swap

# 配置
git clone https://github.com/Hobr/my-nix.git
cd my-nix
# 加密
## GitHub access-tokens
## Clash

# 部署
export all_proxy=socks5://192.168.1.102:7890
nixos-install --option substituters "https://chaotic-nyx.cachix.org/ https://mirrors.sjtug.sjtu.edu.cn/nix-channels/store" --option trusted-public-keys "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8=" --show-trace --flake .#handsonic
reboot
```

## 后续

```bash
# 取消注释 host/default.nix第23行
sudo mkdir /etc/clash

# Fwupd
sudo proxychains4 fwupdmgr refresh
sudo proxychains4 fwupdmgr get-updates
sudo proxychains4 fwupdmgr update

# 安全启动
sudo bootctl status
sudo sbctl create-keys
sudo sbctl verify
reboot
## 打开安全启动并切换到Setup Mode
sudo sbctl enroll-keys --microsoft
reboot
sudo bootctl status

# TPM
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 /dev/nvme0n1

# 开发环境
cd /mnt/data/Project/my-nix
direnv allow
pre-commit install

# SSH
ssh-keygen -t rsa -C "mail@hobr.site"
cat ~/.ssh/id_rsa.pub

# GPG
gpg --list-secret-keys
gpg --import secret-full-key.asc
gpg --import public-key.asc
```

## 参考资料

- [NixOS Wiki](https://nixos.wiki/)
- [NixOS Search](https://search.nixos.org/packages)
- [Home-Manager Option](https://mipmip.github.io/home-manager-option-search/)
- [Misterio77/nix-starter-configs](https://github.com/Misterio77/nix-starter-configs)
- [Chaotic's Nyx](https://www.nyx.chaotic.cx/)
