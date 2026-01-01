cmd_crypto/modules.order := {  :; } | awk '!x[$$0]++' - > crypto/modules.order
