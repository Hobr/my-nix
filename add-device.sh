#!/usr/bin/env bash

# 新设备添加脚本
# 使用方法: ./add-device.sh <device-type> <hostname> <username>

set -euo pipefail

DEVICE_TYPE="$1"
HOSTNAME="$2"
USERNAME="$3"

# 验证设备类型
case "$DEVICE_TYPE" in
    gaming-laptop|portable-laptop|server|nas)
        echo "创建 $DEVICE_TYPE 类型的设备: $HOSTNAME"
        ;;
    *)
        echo "错误: 不支持的设备类型 '$DEVICE_TYPE'"
        echo "支持的类型: gaming-laptop, portable-laptop, server, nas"
        exit 1
        ;;
esac

# 检查文件是否已存在
if [[ -f "system/$HOSTNAME.nix" ]]; then
    echo "错误: system/$HOSTNAME.nix 已存在"
    exit 1
fi

if [[ -f "user/$USERNAME.nix" ]]; then
    echo "错误: user/$USERNAME.nix 已存在"
    exit 1
fi

# 创建系统配置
echo "创建系统配置: system/$HOSTNAME.nix"
cp "templates/$DEVICE_TYPE-system.nix" "system/$HOSTNAME.nix"
sed -i "s/<HOSTNAME>/$HOSTNAME/g" "system/$HOSTNAME.nix"
sed -i "s/<USERNAME>/$USERNAME/g" "system/$HOSTNAME.nix"

# 提示用户输入密码哈希
echo ""
echo "请生成密码哈希:"
echo "mkpasswd -m SHA-512 -s"
read -p "请输入密码哈希: " PASSWORD_HASH
sed -i "s/<HASHED_PASSWORD>/$PASSWORD_HASH/g" "system/$HOSTNAME.nix"

# 创建硬件配置目录
echo "创建硬件配置目录: system/$HOSTNAME/"
mkdir -p "system/$HOSTNAME"

# 创建硬件配置文件模板
cat > "system/$HOSTNAME/hardware.nix" << EOF
# $HOSTNAME 硬件配置
# 从 nixos-generate-config --show-hardware-config 生成
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # TODO: 从 nixos-generate-config 复制硬件配置
  # boot.initrd.availableKernelModules = [ ... ];
  # boot.kernelModules = [ ... ];
  # fileSystems = { ... };
  # swapDevices = [ ... ];
  
  # 网络接口 (根据实际情况调整)
  # networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
EOF

cat > "system/$HOSTNAME/kernel.nix" << EOF
# $HOSTNAME 内核配置
{
  config,
  lib,
  pkgs,
  ...
}:
{
  # 内核版本 (根据需要调整)
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  
  # 内核参数 (根据硬件调整)
  # boot.kernelParams = [ ... ];
  
  # 内核模块 (根据硬件调整)
  # boot.kernelModules = [ ... ];
}
EOF

cat > "system/$HOSTNAME/filesystem.nix" << EOF
# $HOSTNAME 文件系统配置
{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Disko 配置 (如果使用)
  # disko.devices = { ... };
  
  # 文件系统挂载 (从 nixos-generate-config 复制)
  # fileSystems = { ... };
  
  # 交换设备
  # swapDevices = [ ... ];
  
  # 持久化配置 (如果使用 impermanence)
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/nixos"
    ];
    files = [
      "/etc/machine-id"
    ];
  };
}
EOF

# 确定用户配置类型
case "$DEVICE_TYPE" in
    gaming-laptop)
        USER_TYPE="desktop-full"
        ;;
    portable-laptop)
        USER_TYPE="desktop-lite"
        ;;
    server|nas)
        USER_TYPE="server"
        ;;
esac

# 创建用户配置
echo "创建用户配置: user/$USERNAME.nix"
cp "templates/$USER_TYPE-user.nix" "user/$USERNAME.nix"
sed -i "s/<USERNAME>/$USERNAME/g" "user/$USERNAME.nix"

echo ""
echo "设备配置创建完成!"
echo ""
echo "接下来的步骤:"
echo "1. 编辑 system/$HOSTNAME/hardware.nix - 添加硬件配置"
echo "2. 编辑 system/$HOSTNAME/kernel.nix - 调整内核配置"  
echo "3. 编辑 system/$HOSTNAME/filesystem.nix - 配置文件系统"
echo "4. 编辑 user/$USERNAME.nix - 调整用户配置"
echo "5. 更新 flake.nix - 添加新的配置项"
echo ""
echo "flake.nix 需要添加的配置:"
echo ""
echo "nixosConfigurations = {"
echo "  # 现有配置..."
echo "  $HOSTNAME = nixpkgs.lib.nixosSystem {"
echo "    specialArgs = { inherit inputs outputs; };"
echo "    modules = [ ./system/$HOSTNAME.nix ];"
echo "  };"
echo "};"
echo ""
echo "homeConfigurations = {"
echo "  # 现有配置..."
echo "  \"$USERNAME@$HOSTNAME\" = home-manager.lib.homeManagerConfiguration {"
echo "    pkgs = nixpkgs.legacyPackages.x86_64-linux;"
echo "    extraSpecialArgs = { inherit inputs outputs; };"
echo "    modules = [ ./user/$USERNAME.nix ];"
echo "  };"
echo "};"