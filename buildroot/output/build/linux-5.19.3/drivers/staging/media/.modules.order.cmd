cmd_drivers/staging/media/modules.order := {   cat drivers/staging/media/sunxi/modules.order; :; } | awk '!x[$$0]++' - > drivers/staging/media/modules.order
