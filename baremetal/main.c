/* main.c */
#include <stdint.h>

// V3s UART0 寄存器地址 (数据寄存器)
#define UART0_BASE 0x01C28000
#define UART0_THR  (*(volatile uint32_t *)(UART0_BASE + 0x00)) 
#define UART0_LSR  (*(volatile uint32_t *)(UART0_BASE + 0x14))

// 简单的串口发送字符函数
void uart_putc(char c) {
    // 等待发送缓冲区为空 (LSR bit 6)
    while (!(UART0_LSR & (1 << 6)));
    UART0_THR = c;
}

// 简单的字符串打印
void uart_puts(const char *str) {
    while (*str) {
        if (*str == '\n') uart_putc('\r');
        uart_putc(*str++);
    }
}

// 简单的延时
void delay(int count) {
    volatile int i = count;
    while (i--);
}

int main(void) {
    uart_puts("\n\n");
    uart_puts("======================================\n");
    uart_puts("Hello from V3s Bare Metal World!\n");
    uart_puts("I am running at 0x42000000\n");
    uart_puts("======================================\n");

    // 可以在这里做一个倒计时，然后返回 U-Boot
    for (int i = 0; i < 5; i++) {
        uart_puts("Returning to U-Boot in... ");
        uart_putc('5' - i);
        uart_puts("\n");
        delay(1000000); // 粗略延时
    }

    uart_puts("Bye! Jumping back to U-Boot...\n");
    
    // 返回 0 给 start.S，start.S 会带我们回 U-Boot
    return 0;
}