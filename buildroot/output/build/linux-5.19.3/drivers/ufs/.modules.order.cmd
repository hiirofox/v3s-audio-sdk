cmd_drivers/ufs/modules.order := {  :; } | awk '!x[$$0]++' - > drivers/ufs/modules.order
