cmd_drivers/leds/simple/modules.order := {  :; } | awk '!x[$$0]++' - > drivers/leds/simple/modules.order
