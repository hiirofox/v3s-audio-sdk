cmd_drivers/crypto/allwinner/modules.order := {   cat drivers/crypto/allwinner/sun4i-ss/modules.order; :; } | awk '!x[$$0]++' - > drivers/crypto/allwinner/modules.order
