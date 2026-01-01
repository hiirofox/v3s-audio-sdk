cmd_drivers/input/modules.order := {  :; } | awk '!x[$$0]++' - > drivers/input/modules.order
