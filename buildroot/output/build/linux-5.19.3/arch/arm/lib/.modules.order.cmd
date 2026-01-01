cmd_arch/arm/lib/modules.order := {  :; } | awk '!x[$$0]++' - > arch/arm/lib/modules.order
