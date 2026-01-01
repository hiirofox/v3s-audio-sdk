cmd_usr/gen_init_cpio := /usr/bin/gcc -O2 -isystem /home/hiirofox/v3s-sdk/buildroot/output/host/include -L/home/hiirofox/v3s-sdk/buildroot/output/host/lib -Wl,-rpath,/home/hiirofox/v3s-sdk/buildroot/output/host/lib -Wp,-MMD,usr/.gen_init_cpio.d -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu11 -Wdeclaration-after-statement         -o usr/gen_init_cpio usr/gen_init_cpio.c   

source_usr/gen_init_cpio := usr/gen_init_cpio.c

deps_usr/gen_init_cpio := \

usr/gen_init_cpio: $(deps_usr/gen_init_cpio)

$(deps_usr/gen_init_cpio):
