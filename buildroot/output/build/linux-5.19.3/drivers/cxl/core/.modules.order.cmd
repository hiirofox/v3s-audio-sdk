cmd_drivers/cxl/core/modules.order := {  :; } | awk '!x[$$0]++' - > drivers/cxl/core/modules.order
