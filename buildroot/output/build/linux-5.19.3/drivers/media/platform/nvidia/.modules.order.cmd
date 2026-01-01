cmd_drivers/media/platform/nvidia/modules.order := {   cat drivers/media/platform/nvidia/tegra-vde/modules.order; :; } | awk '!x[$$0]++' - > drivers/media/platform/nvidia/modules.order
