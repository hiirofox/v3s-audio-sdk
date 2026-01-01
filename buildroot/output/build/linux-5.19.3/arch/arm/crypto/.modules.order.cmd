cmd_arch/arm/crypto/modules.order := {  :; } | awk '!x[$$0]++' - > arch/arm/crypto/modules.order
