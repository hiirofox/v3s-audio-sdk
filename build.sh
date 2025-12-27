#!/bin/bash
# build.sh - v3s-sdk build helper
# Author: hiirfox
# Usage:
#   ./build.sh init
#   ./build.sh clean          # <--- 新增：修改DTS后执行这个
#   ./build.sh buildroot-config
#   ...

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

# --- 新增的 clean 函数 ---
clean() {
    echo ">>> [Clean] Triggering Linux Kernel and DTS rebuild..."
    
    # 1. 强制重新编译内核 (会更新 DTS)
    # linux-rebuild 会清理内核构建目录并重新编译，比 dirclean + make 更快更精准
    make -C "$BUILDROOT_DIR" O=output BR2_EXTERNAL=board/v3s3 linux-rebuild
    
    # 2. 如果你也修改了 U-Boot 的 DTS，取消下面这行的注释
    # make -C "$BUILDROOT_DIR" O=output BR2_EXTERNAL=board/v3s3 uboot-rebuild
    
    # 3. 重新打包最终镜像 (sdcard.img)
    echo ">>> [Clean] Repacking system images..."
    make -C "$BUILDROOT_DIR" O=output BR2_EXTERNAL=board/v3s3 all
    
    # 4. 自动执行更新拷贝
    updateimg
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

    # 拷贝 images 下所有文件到 SDK 根目录 output
    echo "Copying images to $SDK_ROOT/output/ ..."
    cp -a "$OUTPUT_DIR/images/"* "$SDK_ROOT/output/"
    
    # 尝试拷贝一些可能用到的中间文件 (加了容错处理，防止文件不存在报错)
    if [ -f "$BUILDROOT_DIR/output/build/uboot-2022.01/u-boot-sunxi-with-spl.bin" ]; then
        cp "$BUILDROOT_DIR/output/build/uboot-2022.01/u-boot-sunxi-with-spl.bin" "$SDK_ROOT/output/"
    fi
    
    # 注意：这里的路径可能会随版本变化，建议以 output/images 为准
    # cp "$BUILDROOT_DIR/output/build/host-uboot-tools-2021.07/tools/uboot-env.bin" "$SDK_ROOT/output/" || true
    # cp "$BUILDROOT_DIR/output/build/host-uboot-tools-2021.07/tools/boot.scr" "$SDK_ROOT/output/" || true
    
    echo "Copied files to $SDK_ROOT/output/"
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
        clean)           # <--- 这里增加了 clean 选项
            init
            clean
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
            echo "Usage: $0 [init|clean|buildroot-config|kernel-config|bootloader|kernel|rootfs|updateimg|all]"
            exit 1
            ;;
    esac
fi