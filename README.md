# My NixOS

个人的**NixOS**配置, 日常生活使用, 更新频率较高

## 介绍

- 主机
  - handsonic: 游戏本, 机械革命 Umi Pro 3, Intel i7-11800H, RTX3060, 32G,  双硬盘
  - distortion: 便携触摸本, 联想 Yoga Duet 2020, Intel i5-10210U, Intel UHD630, 16G, 单硬盘
  - overdrive: NAS, Intel E3-1230 v2, 8G, 4硬盘
  - howling: 服务器

- 用户
  - kanade: handsonic用户, 重软件多
  - yuzuru: distortion用户, 重软件少
  - yuri: overdrive用户, 服务器环境
  - miyuki: howling用户, 服务器环境

## TODO

- ZSH Bindkey
- Rime
- Emacs环境
- Systemd-timesyncd resolved....
- 邮箱

### Docker

traefik
gitea
uptime-kuma
Transmission
Jackett
Vaultwarden
jellyfin
Filebrowser
ChineseSubFinder
jackett
syncthing
PhotoPrism
telegraf
Navidrome
music-tag-web
n8n
Musicn
Gotify
Calibre
iptv-sources
Portainer
Nastools
QD
Komga/Bungumi

tieba cloud sign
blog

## 安装

修改内容:

- *system\common\system\boot.nix* 暂时**systemd-boot.enable=true**
- *system\common\system\secureboot.nix* 暂时**lanzaboote.enable=false**, 注释**loader.systemd-boot.enable**

```bash
sudo -i

# 分区
parted /dev/nvme0n1 mklabel gpt

# Boot
mkfs.fat -L Boot /dev/nvme0n1p1

# LUKS
cryptsetup luksFormat /dev/nvme0n1p2
cryptsetup luksOpen /dev/nvme0n1 crypt

# LVM
pvcreate /dev/mapper/crypt
vgcreate system /dev/mapper/crypt

lvcreate -L 16G system -n swap
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

# /mnt/etc/nixos/configuration.nix
nixos-generate-config --root /mnt
rm -rf /mnt/etc

mount -m -t btrfs -o defaults,ssd,discard,noatime,space_cache=v2,compress=zstd,subvol=@nix /dev/mapper/system-root /mnt/nix
mount -m -t btrfs -o defaults,ssd,discard,noatime,space_cache=v2,compress=zstd,subvol=@home /dev/mapper/system-root /mnt/home
mount -m -t btrfs -o defaults,ssd,discard,noatime,space_cache=v2,compress=zstd,subvol=@persist /dev/mapper/system-root /mnt/persist

mount -m /dev/nvme1n1p1 /mnt/boot

# 交换
mkswap -L Swap /dev/mapper/system-swap
swapon /dev/mapper/system-swap

# 配置
git clone https://github.com/Hobr/my-nix.git
cd my-nix

# 部署
export all_proxy=socks5://192.168.1.102:7891
nixos-install --option trusted-substituters "https://chaotic-nyx.cachix.org/ https://mirrors.ustc.edu.cn/nix-channels/store" --option require-sigs false --show-trace --root /mnt --flake .#handsonic/distortion/overdrive

reboot
```

## 后续

```bash
# SUPER+M
# TTY
nmcli
rm ~/.config/hypr/hypyland.conf

# Home
nix-shell -p git
make home
reboot

# 安全启动
# 恢复 system\common\system\secureboot.nix lanzaboote.enable=true, loader.systemd-boot.enable
sudo bootctl status
sudo sbctl create-keys
sudo sbctl verify
reboot
## 打开安全启动并切换到Setup Mode
sudo sbctl enroll-keys --microsoft
reboot
sudo bootctl status

# TPM
sudo systemd-cryptenroll --tpm2-device=list
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 /dev/nvme0n1

# Fwupd
sudo fwupdmgr refresh
sudo fwupdmgr get-updates
sudo fwupdmgr update

# SSH
ssh-keygen -t rsa -C "mail@hobr.site"
## 或者
cp xxx/id_rsa.pub ~/.ssh
cp xxx/id_rsa ~/.ssh
chmod 700 ~/.ssh/id_rsa
chmod 700 ~/.ssh/id_rsa.pub
ssh git@github.com

# GPG
gpg --list-secret-keys
gpg --import secret-full-key.asc
gpg --import public-key.asc

# 重新TPM
sudo cryptsetup luksKillSlot /dev/nvme0n1p4 1
sudo cryptsetup token remove /dev/nvme0n1p4 --token-id 0

# Vivado
nix run gitlab:doronbehar/nix-xilinx#xilinx-shell
chmod +x xxx.bin
./xxx.bin
mkdir ~/.config/xilinx
cp dist/xilinx_nix.sh ~/.config/xilinx/nix.sh
vivado
```

## 参考资料

- [NixOS Wiki](https://nixos.wiki/)
- [NixOS Search](https://search.nixos.org/packages)
- [Home-Manager Option](https://mipmip.github.io/home-manager-option-search/)
- [Misterio77/nix-starter-configs](https://github.com/Misterio77/nix-starter-configs)
- [Chaotic's Nyx](https://www.nyx.chaotic.cx/)
