# My NixOS

个人的**NixOS**配置, 日常生活使用, 更新频率较高

## 介绍

- 主机
  - handsonic: 游戏本, 机械革命 Umi Pro 3, Intel i7-11800H, RTX3060, 32G
  - distortion: 便携触摸本, 联想 Yoga Duet 2020, Intel i5-10210U, Intel UHD630, 16G
  - overdrive: 服务器, 4H4G

- 用户
  - kanade: handsonic用户, 重软件多
  - yuzuru: distortion用户, 重软件少
  - yuri: overdrive用户, 服务器环境

## TODO

- 桌面环境
- ZSH Bindkey
- VSCode环境
- Rime
- ReGreet
- NVim环境
- Emacs环境
- Systemd-timesyncd resolved....
- CCache
- 邮箱

## 安装

修改内容:

- *system\common\config\nix.nix* 填写**access-tokens**
- *system\common\system\boot.nix* 暂时**systemd-boot.enable=true**
- *system\common\system\secureboot.nix* 暂时**lanzaboote.enable=false**, 注释**loader.systemd-boot.enable**

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

# /mnt/etc/nixos/configuration.nix
nixos-generate-config --root /mnt
rm -rf /mnt/etc

mount -m -t btrfs -o defaults,ssd,discard,noatime,space_cache=v2,compress=zstd,subvol=@nix /dev/mapper/system-root /mnt/nix
mount -m -t btrfs -o defaults,ssd,discard,noatime,space_cache=v2,compress=zstd,subvol=@home /dev/mapper/system-root /mnt/home
mount -m -t btrfs -o defaults,ssd,discard,noatime,space_cache=v2,compress=zstd,subvol=@persist /dev/mapper/system-root /mnt/persist

mount -m /dev/nvme1n1p1 /mnt/boot
mount -m -t ntfs3 /dev/nvme1n1p3 /mnt/mnt/windows
mount -m -t ntfs3 /dev/nvme1n1p4 /mnt/mnt/data

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

# 部署
export all_proxy=socks5://192.168.1.102:7890
nixos-install --option substituters "https://chaotic-nyx.cachix.org/ https://mirrors.sjtug.sjtu.edu.cn/nix-channels/store" --option trusted-public-keys "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8=" --show-trace --flake .#handsonic/distortion/overdrive

reboot
```

## 后续

```bash
# scx
zgrep 'SCHED_CLASS' /proc/config.gz
sudo scx_rusty

nmcli
sudo mkdir /etc/clash
sudo systemctl restart Clash

nix-shell -p git
nh home switch -a ./

# system\common\system\boot.nix systemd-boot.enable=true
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
sudo systemd-cryptenroll --tpm2-device=list
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 /dev/nvme0n1

# Fwupd
sudo fwupdmgr refresh
sudo fwupdmgr get-updates
sudo fwupdmgr update

# 开发环境
cd ~/my-nix
direnv allow
pre-commit install

# SSH
ssh-keygen -t rsa -C "mail@hobr.site"
## 或者
cp xxx/id_rsa.pub ~/.ssh
cp xxx/id_rsa ~/.ssh
chmod 700 id_rsa
chmod 700 id_rsa.pub

# GPG
gpg --list-secret-keys
gpg --import secret-full-key.asc
gpg --import public-key.asc

# 重新TPM
sudo cryptsetup luksKillSlot /dev/nvme0n1p4 1
sudo cryptsetup token remove /dev/nvme0n1p4 --token-id 0
```

## 参考资料

- [NixOS Wiki](https://nixos.wiki/)
- [NixOS Search](https://search.nixos.org/packages)
- [Home-Manager Option](https://mipmip.github.io/home-manager-option-search/)
- [Misterio77/nix-starter-configs](https://github.com/Misterio77/nix-starter-configs)
- [Chaotic's Nyx](https://www.nyx.chaotic.cx/)
