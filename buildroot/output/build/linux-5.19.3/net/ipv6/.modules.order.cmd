cmd_net/ipv6/modules.order := {  :; } | awk '!x[$$0]++' - > net/ipv6/modules.order
