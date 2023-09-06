# My NixOS

个人的 ***NixOS***配置, 日常生活中在用, 更新频率较高

## 安装

```bash
sudo -i
# 我个人有两个硬盘, 一个硬盘上安装了 Windows, 我选择共用 Windows的 EFI分区, 另一个盘就分一个区给 LVM, swap和persit文件交给 lvm btrfs
parted /dev/nvme0n1 mklabel gpt
parted /dev/nvme0n1 mkpart Nix 0% 100%
parted /dev/nvme0n1 print

# 加密
cryptsetup --verify-passphrase -v luksFormat /dev/nvme0n1p1
cryptsetup open /dev/nvme0n1p1 crypt

# lvm
pvcreate /dev/mapper/crypt
vgcreate lvm /dev/mapper/crypt

lvcreate -L 24G -n swap lvm
lvcreate -l 100%FREE -n root lvm

# 交换
mkswap -L Swap /dev/lvm/swap
swapon /dev/lvm/swap

##############################################################
# 有Persist
# 子卷
mkfs.btrfs -L NixOS /dev/lvm/root
mount -t btrfs /dev/lvm/root /mnt

btrfs subvolume create /mnt/nix
btrfs subvolume create /mnt/persist
btrfs subvolume list -p /mnt
umount /mnt

# 挂载
mount -t tmpfs -o defaults,mode=755,size=6G none /mnt

mkdir -p /mnt/{home/hobr,nix,persist,boot,mnt/windows,mnt/data}

mount -t tmpfs -o defaults,mode=777,size=6G none /mnt/home/hobr
mount -o compress=zstd,ssd,subvol=nix /dev/lvm/root /mnt/nix
mount -o compress=zstd,ssd,subvol=persist /dev/lvm/root /mnt/persist

mount /dev/nvme1n1p1 /mnt/boot
mount /dev/nvme1n1p3 /mnt/mnt/windows
mount /dev/nvme1n1p4 /mnt/mnt/data

##############################################################

# 无Persist
# 子卷
mkfs.btrfs -L NixOS /dev/lvm/root
mount -t btrfs /dev/lvm/root /mnt

btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/nix
btrfs subvolume list -p /mnt
umount /mnt

# 挂载
mount -o compress=zstd,ssd,subvol=root /dev/lvm/root /mnt

mkdir /mnt/{home,nix,boot,mnt/windows,mnt/data}

mount -o compress=zstd,ssd,subvol=home /dev/lvm/root /mnt/home
mount -o compress=zstd,ssd,subvol=nix /dev/lvm/root /mnt/nix

mount /dev/nvme1n1p1 /mnt/boot
mount /dev/nvme1n1p3 /mnt/mnt/windows
mount /dev/nvme1n1p4 /mnt/mnt/data

##############################################################

# 部署
nixos-generate-config --root /mnt
git clone https://github.com/Hobr/my-nix.git
cd my-nix
## 修改成你的uuid
lsblk -f
nano /mnt/etc/nixos/hardware-configuration.nix
nano system/boot/filesystem.nix
nano system/boot/secure.nix
rm /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/configuration.nix
## 代理
export all_proxy=http://192.168.1.102:10809
nixos-install --option substituters "https://mirrors.sjtug.sjtu.edu.cn/nix-channels/store" --show-trace --flake .#hobr-nixos
reboot

nix-shell
make switch
```

## 参考资料

- [NixOS Wiki](https://nixos.wiki/)
- [Encypted Btrfs Root with Opt-in State on NixOS](https://mt-caret.github.io/blog/posts/2020-06-29-optin-state.html)
- [Misterio77/nix-starter-configs](https://github.com/Misterio77/nix-starter-configs)
- [Ruixi-rebirth/flakes](https://github.com/Ruixi-rebirth/flakes)
- [ryan4yin/nix-config](https://github.com/ryan4yin/nix-config)
