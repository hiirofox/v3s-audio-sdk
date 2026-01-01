cmd_usr/initramfs_data.o := /home/hiirofox/v3s-sdk/buildroot/output/host/bin/arm-buildroot-linux-gnueabihf-gcc -Wp,-MMD,usr/.initramfs_data.o.d -nostdinc -I./arch/arm/include -I./arch/arm/include/generated  -I./include -I./arch/arm/include/uapi -I./arch/arm/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h -D__KERNEL__ -mlittle-endian -fmacro-prefix-map=./= -D__ASSEMBLY__ -fno-PIE -mabi=aapcs-linux -mfpu=vfp -funwind-tables -mtp=cp15 -mthumb -Wa,-mimplicit-it=always -Wa,-mno-warn-deprecated -Wa,-mthumb -D__LINUX_ARM_ARCH__=7 -march=armv7-a -include asm/unified.h -msoft-float    -c -o usr/initramfs_data.o usr/initramfs_data.S 

source_usr/initramfs_data.o := usr/initramfs_data.S

deps_usr/initramfs_data.o := \
    $(wildcard include/config/64BIT) \
  include/linux/compiler-version.h \
    $(wildcard include/config/CC_VERSION_TEXT) \
  include/linux/kconfig.h \
    $(wildcard include/config/CPU_BIG_ENDIAN) \
    $(wildcard include/config/BOOGER) \
    $(wildcard include/config/FOO) \
  arch/arm/include/asm/unified.h \
    $(wildcard include/config/CPU_V7M) \
    $(wildcard include/config/THUMB2_KERNEL) \

usr/initramfs_data.o: $(deps_usr/initramfs_data.o)

$(deps_usr/initramfs_data.o):
