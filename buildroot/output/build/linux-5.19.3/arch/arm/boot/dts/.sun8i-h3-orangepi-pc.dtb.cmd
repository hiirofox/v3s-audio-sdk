cmd_arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb := /usr/bin/gcc -O2 -isystem /home/hiirofox/v3s-sdk/buildroot/output/host/include -L/home/hiirofox/v3s-sdk/buildroot/output/host/lib -Wl,-rpath,/home/hiirofox/v3s-sdk/buildroot/output/host/lib -E -Wp,-MMD,arch/arm/boot/dts/.sun8i-h3-orangepi-pc.dtb.d.pre.tmp -nostdinc -I./scripts/dtc/include-prefixes -undef -D__DTS__ -x assembler-with-cpp -o arch/arm/boot/dts/.sun8i-h3-orangepi-pc.dtb.dts.tmp arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts ; ./scripts/dtc/dtc -o arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb -b 0 -iarch/arm/boot/dts/ -i./scripts/dtc/include-prefixes -Wno-interrupt_provider -Wno-unit_address_vs_reg -Wno-avoid_unnecessary_addr_size -Wno-alias_paths -Wno-graph_child_address -Wno-simple_bus_reg -Wno-unique_unit_address   -d arch/arm/boot/dts/.sun8i-h3-orangepi-pc.dtb.d.dtc.tmp arch/arm/boot/dts/.sun8i-h3-orangepi-pc.dtb.dts.tmp ; cat arch/arm/boot/dts/.sun8i-h3-orangepi-pc.dtb.d.pre.tmp arch/arm/boot/dts/.sun8i-h3-orangepi-pc.dtb.d.dtc.tmp > arch/arm/boot/dts/.sun8i-h3-orangepi-pc.dtb.d

source_arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb := arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts

deps_arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb := \
  arch/arm/boot/dts/sun8i-h3.dtsi \
  arch/arm/boot/dts/sunxi-h3-h5.dtsi \
  scripts/dtc/include-prefixes/dt-bindings/clock/sun8i-de2.h \
  scripts/dtc/include-prefixes/dt-bindings/clock/sun8i-h3-ccu.h \
  scripts/dtc/include-prefixes/dt-bindings/clock/sun8i-r-ccu.h \
  scripts/dtc/include-prefixes/dt-bindings/interrupt-controller/arm-gic.h \
  scripts/dtc/include-prefixes/dt-bindings/interrupt-controller/irq.h \
  scripts/dtc/include-prefixes/dt-bindings/reset/sun8i-de2.h \
  scripts/dtc/include-prefixes/dt-bindings/reset/sun8i-h3-ccu.h \
  scripts/dtc/include-prefixes/dt-bindings/reset/sun8i-r-ccu.h \
  scripts/dtc/include-prefixes/dt-bindings/thermal/thermal.h \
  arch/arm/boot/dts/sunxi-common-regulators.dtsi \
  scripts/dtc/include-prefixes/dt-bindings/gpio/gpio.h \
  scripts/dtc/include-prefixes/dt-bindings/input/input.h \
  scripts/dtc/include-prefixes/dt-bindings/input/linux-event-codes.h \

arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb: $(deps_arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb)

$(deps_arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb):
