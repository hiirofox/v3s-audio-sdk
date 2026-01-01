cmd_drivers/cxl/modules.order := {   cat drivers/cxl/core/modules.order; :; } | awk '!x[$$0]++' - > drivers/cxl/modules.order
