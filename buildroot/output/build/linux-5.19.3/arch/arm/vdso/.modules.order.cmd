cmd_arch/arm/vdso/modules.order := {  :; } | awk '!x[$$0]++' - > arch/arm/vdso/modules.order
