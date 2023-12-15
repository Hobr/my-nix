# My NixOS

个人的 ***NixOS***配置, 日常生活中在用, 更新频率较高

## 安装

```bash
sudo -i
parted /dev/nvme0n1 mklabel gpt

# 加密
cryptsetup --verify-passphrase -v luksFormat /dev/nvme0n1
cryptsetup open /dev/nvme0n1 crypt

# LVM
pvcreate /dev/mapper/crypt
vgcreate system /dev/mapper/crypt

lvcreate -L 24G system -n swap
lvcreate -l 100%FREE system -n root

# 交换
mkswap -L Swap /dev/mapper/system-swap
swapon /dev/mapper/system-swap

# 子卷
mkfs.btrfs -L NixOS /dev/mapper/system-root
mount -m /dev/mapper/system-root /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@root
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@cache
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@local
btrfs subvolume list /mnt
umount /mnt

# 挂载
mount -m -t btrfs -o defaults,ssd,discard,noatime,space_cache=v2,compress=lzo,subvol=@ /dev/mapper/system-root /mnt
mount -m -t btrfs -o defaults,ssd,discard,noatime,space_cache=v2,compress=lzo,subvol=@root /dev/mapper/system-root /mnt/root
mount -m -t btrfs -o defaults,ssd,discard,noatime,space_cache=v2,compress=lzo,subvol=@home /dev/mapper/system-root /mnt/home
mount -m -t btrfs -o defaults,ssd,discard,noatime,space_cache=v2,compress=lzo,subvol=@cache /dev/mapper/system-root /mnt/var/cache
mount -m -t btrfs -o defaults,ssd,discard,noatime,space_cache=v2,compress=lzo,subvol=@log /dev/mapper/system-root /mnt/var/log
mount -m -t btrfs -o defaults,ssd,discard,noatime,space_cache=v2,compress=lzo,subvol=@local /dev/mapper/system-root /mnt/usr/local

mount /dev/nvme1n1p1 /mnt/boot
mount /dev/nvme1n1p3 /mnt/mnt/windows
mount /dev/nvme1n1p4 /mnt/mnt/data

# 部署
nixos-generate-config --root /mnt
mkdir /mnt/persist/home/hobr/Docs
cd /mnt/persist/home/hobr/Docs
git clone https://github.com/Hobr/my-nix.git
cd my-nix

lsblk -f
nano /mnt/etc/nixos/hardware-configuration.nix
rm /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/configuration.nix

# 代理
export all_proxy=http://192.168.1.102:10809
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
