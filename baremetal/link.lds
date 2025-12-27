/* link.lds */
OUTPUT_ARCH(arm)
ENTRY(_start)

SECTIONS
{
    /* 设定入口地址，这对 u-boot go 命令至关重要 */
    . = 0x42000000;

    .text : {
        *(.text.start) /* 确保 start.S 里的代码放在最最前面 */
        *(.text)
    }

    .data : {
        *(.data)
    }

    .bss : {
        *(.bss)
    }
}