cmd_arch/arm/common/modules.order := {  :; } | awk '!x[$$0]++' - > arch/arm/common/modules.order
