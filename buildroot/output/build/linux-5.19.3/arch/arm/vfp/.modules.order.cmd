cmd_arch/arm/vfp/modules.order := {  :; } | awk '!x[$$0]++' - > arch/arm/vfp/modules.order
