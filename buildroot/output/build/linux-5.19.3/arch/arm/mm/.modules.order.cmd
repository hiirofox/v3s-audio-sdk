cmd_arch/arm/mm/modules.order := {  :; } | awk '!x[$$0]++' - > arch/arm/mm/modules.order
