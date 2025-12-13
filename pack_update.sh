#!/bin/bash
set -e

# ========================================
# SDCard 专用 打包脚本
# ========================================

SDK_DIR=$(cd "$(dirname "$0")" && pwd)
OUTPUT_DIR="${SDK_DIR}/output"
PACKTOOLS_DIR="${SDK_DIR}/tools/pack"
PACK_OUT_DIR="${PACKTOOLS_DIR}/out"

# -----------------------------
# Buildroot 输出文件
# -----------------------------
UBOOT_SPL="${OUTPUT_DIR}/u-boot-sunxi-with-spl.bin"
UBOOT_BIN="${OUTPUT_DIR}/u-boot.bin"
ROOTFS="${OUTPUT_DIR}/rootfs.ext4"
BOOTSCR="${OUTPUT_DIR}/boot.scr"
DTB="${OUTPUT_DIR}/sun8i-v3s-licheepi-zero.dtb"
KERNEL_IMG="${OUTPUT_DIR}/zImage"

# SD 卡镜像输出
SDCARD_IMG="${OUTPUT_DIR}/sdcard.img"

# -----------------------------
# 检查输出文件
# -----------------------------
echo "Checking Buildroot output files..."
for f in "$UBOOT_SPL" "$ROOTFS" "$BOOTSCR" "$DTB" "$KERNEL_IMG"; do
    if [ ! -f "$f" ]; then
        echo "ERROR: Required file $f not found!"
        exit 1
    fi
done
echo "Buildroot output OK."

# -----------------------------
# 准备 pack 所需目录
# -----------------------------
mkdir -p "$PACK_OUT_DIR/arch/arm/boot"
mkdir -p "$PACK_OUT_DIR/image"

# kernel
ln -sf "$KERNEL_IMG" "$PACK_OUT_DIR/arch/arm/boot/zImage"
ln -sf "arch/arm/boot/zImage" "$PACK_OUT_DIR/boot.fex"

# dtb
ln -sf "$DTB" "$PACK_OUT_DIR/sunxi.dtb"

# rootfs（EXT4，SDCard 直接用）
ln -sf "$ROOTFS" "$PACK_OUT_DIR/rootfs.ext4"

# -----------------------------
# 调用 pack 工具（SDCard）
# -----------------------------
echo "Starting pack for SDCard..."
cd "$PACKTOOLS_DIR"

./pack \
  -c sun8iw8p1 \
  -p camdroid \
  -b tiger-standard \
  -e sdcard \
  output/u-boot-sunxi-with-spl.bin \
  output/uboot-env.bin \
  tools/pack/out/rootfs.fex \
  tools/pack/out/boot.fex \
  output/update.img

# -----------------------------
# 检查 sdcard.img
# -----------------------------
if [ -f "$SDCARD_IMG" ]; then
    echo "sdcard.img successfully created at $SDCARD_IMG"
else
    echo "ERROR: sdcard.img not generated!"
    exit 1
fi
