cmd_scripts/dtc/libfdt/fdt_empty_tree.o := /usr/bin/gcc -O2 -isystem /home/hiirofox/v3s-sdk/buildroot/output/host/include -L/home/hiirofox/v3s-sdk/buildroot/output/host/lib -Wl,-rpath,/home/hiirofox/v3s-sdk/buildroot/output/host/lib -Wp,-MMD,scripts/dtc/libfdt/.fdt_empty_tree.o.d -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu11 -Wdeclaration-after-statement     -I ./scripts/dtc/libfdt -DNO_YAML  -c -o scripts/dtc/libfdt/fdt_empty_tree.o scripts/dtc/libfdt/fdt_empty_tree.c

source_scripts/dtc/libfdt/fdt_empty_tree.o := scripts/dtc/libfdt/fdt_empty_tree.c

deps_scripts/dtc/libfdt/fdt_empty_tree.o := \
  scripts/dtc/libfdt/libfdt_env.h \
  scripts/dtc/libfdt/fdt.h \
  scripts/dtc/libfdt/libfdt.h \
  scripts/dtc/libfdt/libfdt_env.h \
  scripts/dtc/libfdt/fdt.h \
  scripts/dtc/libfdt/libfdt_internal.h \

scripts/dtc/libfdt/fdt_empty_tree.o: $(deps_scripts/dtc/libfdt/fdt_empty_tree.o)

$(deps_scripts/dtc/libfdt/fdt_empty_tree.o):
