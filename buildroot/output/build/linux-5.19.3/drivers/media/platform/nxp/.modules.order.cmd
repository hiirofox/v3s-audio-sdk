cmd_drivers/media/platform/nxp/modules.order := {   cat drivers/media/platform/nxp/imx-jpeg/modules.order; :; } | awk '!x[$$0]++' - > drivers/media/platform/nxp/modules.order
