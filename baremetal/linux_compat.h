#ifndef _LINUX_COMPAT_H
#define _LINUX_COMPAT_H

/* 1. 引入权威类型定义 (解决 phys_addr_t, u32 等) */
#include <linux/types.h>
#include <linux/compiler.h>

/* 2. 补全 dma_addr_t (Linux Tools 里通常缺这个) */
/* V3s 是32位系统，直接定义为 u32 即可 */
typedef u32 dma_addr_t; 

/* 3. 模拟 U-Boot 环境 */
#ifndef __KERNEL__
#define __KERNEL__
#endif
#undef CONFIG_ARM64
#undef CONFIG_PHYS_64BIT

/* 4. 引入硬件 IO (现在链接修好了，这里能通了) */
#include <asm/io.h> 

/* 5. 常用宏 */
#ifndef ARRAY_SIZE
#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
#endif

#ifndef BIT
#define BIT(nr) (1UL << (nr))
#endif

#define __iomem

/* 6. 打印与错误码 */
#include <stdio.h>
#define pr_err(fmt, ...)  printf("[ERR] " fmt, ##__VA_ARGS__)
#define pr_info(fmt, ...) printf("[INF] " fmt, ##__VA_ARGS__)
#define dev_err(dev, fmt, ...) printf("[DEV] " fmt, ##__VA_ARGS__)

#define ENOMEM 12
#define EINVAL 22
#define EBUSY  16


/* =========================================================
   6. 核心内核功能模拟 (Stubbing)
   把复杂的内核机制变成“空操作”或“直通操作”
   ========================================================= */

/* --- 1. 内存管理 --- */
/* 裸机没有内核堆，这里搞个简单的静态 buffer 骗过驱动 */
/* 警告：这是临时方案，只能支持单次初始化 */
static char _fake_heap[4096]; 
static int _heap_pos = 0;
#define GFP_KERNEL 0

static inline void *devm_kzalloc(struct device *dev, size_t size, int flags) {
    void *ptr = &_fake_heap[_heap_pos];
    _heap_pos += size; // 简单的线性分配，不回收
    if (_heap_pos > sizeof(_fake_heap)) {
        printf("Fake Heap Overflow!\n"); 
        return NULL;
    }
    // 简单的清零
    char *p = ptr;
    for(int i=0; i<size; i++) p[i] = 0;
    return ptr;
}

/* --- 2. 设备结构体模拟 --- */
/* 我们不解析 DTB，我们在 main.c 里手动构造这个结构体 */
struct device_node { const char *name; };
struct device {
    struct device_node *of_node;
    void *driver_data; // 存放私有数据 (scodec)
};
struct platform_device {
    const char *name;
    int id;
    struct device dev;
    unsigned long res_base; // 手动填入基地址
};

/* 获取驱动私有数据 */
static inline void platform_set_drvdata(struct platform_device *pdev, void *data) {
    pdev->dev.driver_data = data;
}
static inline void *dev_get_drvdata(struct device *dev) {
    return dev->driver_data;
}

/* 获取基地址 (忽略 index，直接返回我们写死在 pdev 里的 res_base) */
static inline void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev, int index) {
    return (void __iomem *)pdev->res_base;
}

/* 匹配数据 (Quirks) - 直接返回 NULL 或者你手动定义的 quirks */
static inline const void *of_device_get_match_data(const struct device *dev) {
    // 这里如果驱动依赖 quirks，我们需要在 main.c 里定义并在这里返回
    // 暂时返回 NULL 碰碰运气，或者硬编码 V3s 的配置
    return NULL; 
}

/* --- 3. 时钟与复位 (Clock & Reset) --- */
/* 裸机里，我们在调用驱动前，自己手动操作寄存器开启时钟。
   所以这里的驱动调用，全部返回“成功”(0) 即可 */
struct clk { int dummy; };
#define IS_ERR(ptr) ((unsigned long)(ptr) > (unsigned long)-1000L)
#define PTR_ERR(ptr) ((long)(ptr))

static inline struct clk *devm_clk_get(struct device *dev, const char *id) {
    return (struct clk *)1; // 返回一个非空指针
}
static inline int clk_prepare_enable(struct clk *clk) { return 0; }
static inline void clk_disable_unprepare(struct clk *clk) { }
static inline int clk_set_rate(struct clk *clk, unsigned long rate) { return 0; }
/* 处理 exclusive rate 的空函数 */
static inline int clk_set_rate_exclusive(struct clk *clk, unsigned long rate) { return 0; }
static inline void clk_rate_exclusive_put(struct clk *clk) { }


/* --- 4. Regmap (寄存器映射) --- */
/* 这是核心！把 regmap 操作映射回 writel/readl */
struct regmap { void __iomem *base; };
struct regmap_config {
    int reg_bits; int val_bits; int reg_stride; int max_register; int cache_type;
};
#define REGCACHE_FLAT 0

static inline struct regmap *devm_regmap_init_mmio_clk(struct device *dev, const char *clk_id,
                                            void __iomem *regs, const struct regmap_config *config) {
    struct regmap *map = (struct regmap *)devm_kzalloc(dev, sizeof(struct regmap), 0);
    map->base = regs;
    return map;
}

static inline int regmap_write(struct regmap *map, unsigned int reg, unsigned int val) {
    writel(val, map->base + reg);
    return 0;
}
static inline int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val) {
    *val = readl(map->base + reg);
    return 0;
}
static inline int regmap_update_bits(struct regmap *map, unsigned int reg, unsigned int mask, unsigned int val) {
    unsigned int tmp, orig;
    regmap_read(map, reg, &orig);
    tmp = orig & ~mask;
    tmp |= val & mask;
    regmap_write(map, reg, tmp);
    return 0;
}
/* 裸机不需要 sync cache，因为我们直接写寄存器 */
static inline int regcache_sync(struct regmap *map) { return 0; }
static inline void regcache_cache_only(struct regmap *map, bool enable) {}
static inline void regcache_mark_dirty(struct regmap *map) {}

/* --- 5. 电源管理 (PM) --- */
/* 全部打桩通过 */
static inline void pm_runtime_enable(struct device *dev) {}
static inline void pm_runtime_disable(struct device *dev) {}
static inline int pm_runtime_get_sync(struct device *dev) { return 0; }
static inline void pm_runtime_put(struct device *dev) {}
static inline int pm_runtime_status_suspended(struct device *dev) { return 0; }

/* --- 6. 忽略 ASoC 框架复杂宏 --- */
/* 这些宏定义了大量结构体，我们暂时用不到，只要能编译过就行 */
#define MODULE_DEVICE_TABLE(type, name)
#define MODULE_AUTHOR(name)
#define MODULE_DESCRIPTION(desc)
#define MODULE_LICENSE(lic)
#define MODULE_ALIAS(alias)
#define module_platform_driver(drv) // 这一行最重要！我们要手动调用 probe，不要系统自动加载

/* 忽略 SND_SOC 相关的结构体填充警告，或者定义空宏 */
/* 如果 snd_soc_dai_driver 报错，你需要定义一个空的 struct snd_soc_dai_driver */

#endif