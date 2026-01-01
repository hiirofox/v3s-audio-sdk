cmd_arch/arm/probes/modules.order := {  :; } | awk '!x[$$0]++' - > arch/arm/probes/modules.order
