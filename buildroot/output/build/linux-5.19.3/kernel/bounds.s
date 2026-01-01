	.arch armv7-a
	.fpu softvfp
	.eabi_attribute 20, 1	@ Tag_ABI_FP_denormal
	.eabi_attribute 21, 1	@ Tag_ABI_FP_exceptions
	.eabi_attribute 23, 3	@ Tag_ABI_FP_number_model
	.eabi_attribute 24, 1	@ Tag_ABI_align8_needed
	.eabi_attribute 25, 1	@ Tag_ABI_align8_preserved
	.eabi_attribute 26, 2	@ Tag_ABI_enum_size
	.eabi_attribute 30, 4	@ Tag_ABI_optimization_goals
	.eabi_attribute 34, 1	@ Tag_CPU_unaligned_access
	.eabi_attribute 18, 2	@ Tag_ABI_PCS_wchar_t
	.file	"bounds.c"
@ GNU C11 (Buildroot 2024.08) version 13.3.0 (arm-buildroot-linux-gnueabihf)
@	compiled by GNU C version 13.3.0, GMP version 6.3.0, MPFR version 4.1.1, MPC version 1.3.1, isl version none
@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mlittle-endian -mabi=aapcs-linux -mfpu=vfp -mtp=cp15 -mthumb -mfloat-abi=soft -mtls-dialect=gnu -march=armv7-a -Os -std=gnu11 -fstack-protector-strong -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -fno-dwarf2-cfi-asm -fno-ipa-sra -funwind-tables -fno-delete-null-pointer-checks -fno-allow-store-data-races -fno-stack-protector -fomit-frame-pointer -ftrivial-auto-var-init=zero -fno-stack-clash-protection -fno-strict-overflow -fstack-check=no -fconserve-stack
	.text
	.syntax unified
	.syntax unified
	.thumb
	.syntax unified
	.section	.text.startup,"ax",%progbits
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function
main:
	.fnstart
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ kernel/bounds.c:19: 	DEFINE(NR_PAGEFLAGS, __NR_PAGEFLAGS);
	.syntax unified
@ 19 "kernel/bounds.c" 1
	
.ascii "->NR_PAGEFLAGS #22 __NR_PAGEFLAGS"	@
@ 0 "" 2
@ kernel/bounds.c:20: 	DEFINE(MAX_NR_ZONES, __MAX_NR_ZONES);
@ 20 "kernel/bounds.c" 1
	
.ascii "->MAX_NR_ZONES #2 __MAX_NR_ZONES"	@
@ 0 "" 2
@ kernel/bounds.c:24: 	DEFINE(SPINLOCK_SIZE, sizeof(spinlock_t));
@ 24 "kernel/bounds.c" 1
	
.ascii "->SPINLOCK_SIZE #0 sizeof(spinlock_t)"	@
@ 0 "" 2
@ kernel/bounds.c:28: }
	.thumb
	.syntax unified
	movs	r0, #0	@,
	bx	lr	@
	.fnend
	.size	main, .-main
	.ident	"GCC: (Buildroot 2024.08) 13.3.0"
	.section	.note.GNU-stack,"",%progbits
