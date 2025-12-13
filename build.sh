#!/bin/bash
# build.sh - v3s-sdk build helper
# Author: hiirfox
# Usage:
#   ./build.sh init
#   ./build.sh buildroot-config
#   ./build.sh kernel-config
#   ./build.sh bootloader
#   ./build.sh kernel
#   ./build.sh rootfs
#   ./build.sh updateimg
#   ./build.sh           # build all

set -e

SDK_ROOT="$(cd "$(dirname "$0")" && pwd)"
BUILDROOT_DIR="$SDK_ROOT/buildroot"
OUTPUT_DIR="$BUILDROOT_DIR/output"

# ====== 功能函数 ======
init() {
    # 排除 PATH 中带空格的目录，防止 WSL 错误
    export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/bin

    echo "PATH sanitized for WSL."
}

buildroot_config() {
    echo "Opening Buildroot menuconfig..."
    make -C "$BUILDROOT_DIR" O=output BR2_EXTERNAL=board/v3s3 menuconfig
    echo "Buildroot menuconfig done."
    make -C "$BUILDROOT_DIR" O=output BR2_EXTERNAL=board/v3s3 savedefconfig
    echo "Buildroot menuconfig saved."
}

kernel_config() {
    KERNEL_BUILD="$OUTPUT_DIR/build/linux-5.19.3"
    if [ ! -d "$KERNEL_BUILD" ]; then
        echo "Kernel build directory not found, please build Buildroot once first."
        exit 1
    fi
    echo "Opening full Linux kernel menuconfig..."
    make -C "$KERNEL_BUILD" ARCH=arm menuconfig
    # 自动保存 defconfig
    make -C "$KERNEL_BUILD" ARCH=arm savedefconfig
    cp "$KERNEL_BUILD/defconfig" "$SDK_ROOT/board/licheepi/linux/my_v3s_defconfig"
    echo "Kernel defconfig saved to board/licheepi/linux/my_v3s_defconfig"
}

build_module() {
    local module="$1"
    case "$module" in
        bootloader)
            echo "Building bootloader..."
            make -C "$BUILDROOT_DIR" u-boot
            ;;
        kernel)
            echo "Building kernel..."
            make -C "$BUILDROOT_DIR" linux
            ;;
        rootfs)
            echo "Building root filesystem..."
            make -C "$BUILDROOT_DIR" target
            ;;
        *)
            echo "Unknown module: $module"
            exit 1
            ;;
    esac
}

build_all() {
    echo "Building all modules..."
    make -C "$BUILDROOT_DIR" O=output BR2_EXTERNAL=board/v3s3 -j$(nproc)
}
updateimg() {
    echo "Generating update.img and copying images..."
    # 确保 output 目录存在
    rm -rf "$SDK_ROOT/output"
    mkdir -p "$SDK_ROOT/output"

    # 调用 Buildroot 生成 sdcard.img（如果之前没有生成）
    # make -C "$BUILDROOT_DIR" sdcard.img

    # 拷贝 images 下所有文件到 SDK 根目录 output
    echo "Copying images to $SDK_ROOT/output/ ..."
    cp -a "$OUTPUT_DIR/images/"* "$SDK_ROOT/output/"
    cp "$BUILDROOT_DIR/output/build/uboot-2022.01/u-boot-sunxi-with-spl.bin" "$SDK_ROOT/output/"
    cp "$BUILDROOT_DIR/output/build/host-uboot-tools-2021.07/tools/uboot-env.bin" "$SDK_ROOT/output/"
    cp "$BUILDROOT_DIR/output/build/host-uboot-tools-2021.07/tools/boot.scr" "$SDK_ROOT/output/"
    cp "$BUILDROOT_DIR/output/build/uboot-2022.01/arch/arm/dts/sun8i-v3s-licheepi-zero.dtb" "$SDK_ROOT/output/"
    echo "Copied the following files:"
    ls -l "$SDK_ROOT/output/"
}

# ====== 主逻辑 ======
if [ $# -eq 0 ]; then
    # 什么也不写：build all + updateimg
    init
    build_all
    updateimg
else
    case "$1" in
        init)
            init
            ;;
        buildroot-config)
            init
            buildroot_config
            ;;
        kernel-config)
            init
            kernel_config
            ;;
        bootloader|kernel|rootfs)
            init
            build_module "$1"
            ;;
        updateimg)
            updateimg
            ;;
        all)
            init
            build_all
            updateimg
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 [init|buildroot-config|kernel-config|bootloader|kernel|rootfs|updateimg|all]"
            exit 1
            ;;
    esac
fi
