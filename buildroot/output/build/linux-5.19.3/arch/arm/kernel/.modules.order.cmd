cmd_arch/arm/kernel/modules.order := {  :; } | awk '!x[$$0]++' - > arch/arm/kernel/modules.order
