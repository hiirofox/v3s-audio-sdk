/* start.S */
.global _start

_start:
    /* 1. 保存 U-Boot 的返回地址 (LR) 到栈中 */
    push {lr}

    /* 2. (可选) 这里可以使用 U-Boot 的栈，也可以自己设置栈 
       为了简单，我们暂时借用 U-Boot 的栈，因为我们只跑简单的 C 代码
    */

    /* 3. 跳转到 C 语言的 main 函数 */
    bl main

    /* 4. main 函数执行完毕返回后，从栈中恢复 LR 到 PC，实现返回 U-Boot */
    pop {pc}