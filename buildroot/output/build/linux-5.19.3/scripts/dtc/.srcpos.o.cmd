cmd_scripts/dtc/srcpos.o := /usr/bin/gcc -O2 -isystem /home/hiirofox/v3s-sdk/buildroot/output/host/include -L/home/hiirofox/v3s-sdk/buildroot/output/host/lib -Wl,-rpath,/home/hiirofox/v3s-sdk/buildroot/output/host/lib -Wp,-MMD,scripts/dtc/.srcpos.o.d -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu11 -Wdeclaration-after-statement     -I ./scripts/dtc/libfdt -DNO_YAML  -c -o scripts/dtc/srcpos.o scripts/dtc/srcpos.c

source_scripts/dtc/srcpos.o := scripts/dtc/srcpos.c

deps_scripts/dtc/srcpos.o := \
  scripts/dtc/dtc.h \
  scripts/dtc/libfdt/libfdt_env.h \
  scripts/dtc/libfdt/fdt.h \
  scripts/dtc/util.h \
  scripts/dtc/srcpos.h \

scripts/dtc/srcpos.o: $(deps_scripts/dtc/srcpos.o)

$(deps_scripts/dtc/srcpos.o):
