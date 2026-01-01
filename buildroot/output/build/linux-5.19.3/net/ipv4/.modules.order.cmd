cmd_net/ipv4/modules.order := {  :; } | awk '!x[$$0]++' - > net/ipv4/modules.order
