cmd_arch/arm/vdso/vdsomunge := /usr/bin/gcc -O2 -isystem /home/hiirofox/v3s-sdk/buildroot/output/host/include -L/home/hiirofox/v3s-sdk/buildroot/output/host/lib -Wl,-rpath,/home/hiirofox/v3s-sdk/buildroot/output/host/lib -Wp,-MMD,arch/arm/vdso/.vdsomunge.d -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu11 -Wdeclaration-after-statement         -o arch/arm/vdso/vdsomunge arch/arm/vdso/vdsomunge.c   

source_arch/arm/vdso/vdsomunge := arch/arm/vdso/vdsomunge.c

deps_arch/arm/vdso/vdsomunge := \

arch/arm/vdso/vdsomunge: $(deps_arch/arm/vdso/vdsomunge)

$(deps_arch/arm/vdso/vdsomunge):
