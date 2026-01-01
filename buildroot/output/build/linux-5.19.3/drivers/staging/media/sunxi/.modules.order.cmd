cmd_drivers/staging/media/sunxi/modules.order := {   cat drivers/staging/media/sunxi/cedar/modules.order; :; } | awk '!x[$$0]++' - > drivers/staging/media/sunxi/modules.order
