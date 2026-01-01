cmd_scripts/sorttable := /usr/bin/gcc -O2 -isystem /home/hiirofox/v3s-sdk/buildroot/output/host/include -L/home/hiirofox/v3s-sdk/buildroot/output/host/lib -Wl,-rpath,/home/hiirofox/v3s-sdk/buildroot/output/host/lib -Wp,-MMD,scripts/.sorttable.d -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu11 -Wdeclaration-after-statement      -I./tools/include   -o scripts/sorttable scripts/sorttable.c   -lpthread

source_scripts/sorttable := scripts/sorttable.c

deps_scripts/sorttable := \
  tools/include/tools/be_byteshift.h \
  tools/include/tools/le_byteshift.h \
  scripts/sorttable.h \

scripts/sorttable: $(deps_scripts/sorttable)

$(deps_scripts/sorttable):
