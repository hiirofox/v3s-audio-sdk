# Makefile

# 1. 定义输出目录
OUTPUT_DIR = output

# 指向 Buildroot 生成的工具链
CROSS_COMPILE := ../buildroot/output/host/bin/arm-buildroot-linux-gnueabihf-

CC      = $(CROSS_COMPILE)gcc
LD      = $(CROSS_COMPILE)ld
OBJCOPY = $(CROSS_COMPILE)objcopy
OBJDUMP = $(CROSS_COMPILE)objdump

# 编译选项
CFLAGS  = -O2 -nostdlib -fno-builtin -march=armv7-a -mfloat-abi=hard
LDFLAGS = -T link.lds

# 2. 定义目标文件的完整路径
TARGET_NAME = app
TARGET_ELF  = $(OUTPUT_DIR)/$(TARGET_NAME).elf
TARGET_BIN  = $(OUTPUT_DIR)/$(TARGET_NAME).bin
TARGET_DIS  = $(OUTPUT_DIR)/$(TARGET_NAME).dis

# 3. 关键：给对象文件加上输出目录前缀
# 这样 start.o 就变成了 output/start.o
OBJS_NAMES = start.o main.o
OBJS       = $(addprefix $(OUTPUT_DIR)/, $(OBJS_NAMES))

# 默认目标
all: $(OUTPUT_DIR) $(TARGET_BIN)

# 创建输出目录 (如果不存在)
$(OUTPUT_DIR):
	mkdir -p $@

# 生成最终 bin 文件
$(TARGET_BIN): $(TARGET_ELF)
	$(OBJCOPY) -O binary $< $@
	$(OBJDUMP) -D $(TARGET_ELF) > $(TARGET_DIS)
	@echo "Build success! Output is in $(OUTPUT_DIR)/"

# 链接 elf 文件
$(TARGET_ELF): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^

# 编译 C 文件规则
# $(OUTPUT_DIR)/%.o 匹配 output/xxx.o
# %.c 匹配当前目录下的 xxx.c
$(OUTPUT_DIR)/%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

# 编译汇编文件规则
$(OUTPUT_DIR)/%.o: %.S
	$(CC) $(CFLAGS) -c -o $@ $<

# 清理规则：直接删除 output 目录
clean:
	rm -rf $(OUTPUT_DIR)