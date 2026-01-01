cmd_drivers/firmware/cirrus/modules.order := {  :; } | awk '!x[$$0]++' - > drivers/firmware/cirrus/modules.order
