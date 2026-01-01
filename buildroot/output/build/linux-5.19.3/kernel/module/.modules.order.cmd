cmd_kernel/module/modules.order := {  :; } | awk '!x[$$0]++' - > kernel/module/modules.order
