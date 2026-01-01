cmd_drivers/scsi/arm/modules.order := {  :; } | awk '!x[$$0]++' - > drivers/scsi/arm/modules.order
