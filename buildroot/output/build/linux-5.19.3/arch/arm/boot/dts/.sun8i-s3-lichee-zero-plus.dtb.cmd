cmd_arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dtb := /usr/bin/gcc -O2 -isystem /home/hiirofox/v3s-sdk/buildroot/output/host/include -L/home/hiirofox/v3s-sdk/buildroot/output/host/lib -Wl,-rpath,/home/hiirofox/v3s-sdk/buildroot/output/host/lib -E -Wp,-MMD,arch/arm/boot/dts/.sun8i-s3-lichee-zero-plus.dtb.d.pre.tmp -nostdinc -I./scripts/dtc/include-prefixes -undef -D__DTS__ -x assembler-with-cpp -o arch/arm/boot/dts/.sun8i-s3-lichee-zero-plus.dtb.dts.tmp arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dts ; ./scripts/dtc/dtc -o arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dtb -b 0 -iarch/arm/boot/dts/ -i./scripts/dtc/include-prefixes -Wno-interrupt_provider -Wno-unit_address_vs_reg -Wno-avoid_unnecessary_addr_size -Wno-alias_paths -Wno-graph_child_address -Wno-simple_bus_reg -Wno-unique_unit_address   -d arch/arm/boot/dts/.sun8i-s3-lichee-zero-plus.dtb.d.dtc.tmp arch/arm/boot/dts/.sun8i-s3-lichee-zero-plus.dtb.dts.tmp ; cat arch/arm/boot/dts/.sun8i-s3-lichee-zero-plus.dtb.d.pre.tmp arch/arm/boot/dts/.sun8i-s3-lichee-zero-plus.dtb.d.dtc.tmp > arch/arm/boot/dts/.sun8i-s3-lichee-zero-plus.dtb.d

source_arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dtb := arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dts

deps_arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dtb := \
  arch/arm/boot/dts/sun8i-v3.dtsi \
  arch/arm/boot/dts/sun8i-v3s.dtsi \
  scripts/dtc/include-prefixes/dt-bindings/interrupt-controller/arm-gic.h \
  scripts/dtc/include-prefixes/dt-bindings/interrupt-controller/irq.h \
  scripts/dtc/include-prefixes/dt-bindings/clock/sun8i-v3s-ccu.h \
  scripts/dtc/include-prefixes/dt-bindings/reset/sun8i-v3s-ccu.h \
  scripts/dtc/include-prefixes/dt-bindings/clock/sun8i-de2.h \
  scripts/dtc/include-prefixes/dt-bindings/gpio/gpio.h \

arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dtb: $(deps_arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dtb)

$(deps_arch/arm/boot/dts/sun8i-s3-lichee-zero-plus.dtb):
