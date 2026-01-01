cmd_arch/arm/net/modules.order := {  :; } | awk '!x[$$0]++' - > arch/arm/net/modules.order
