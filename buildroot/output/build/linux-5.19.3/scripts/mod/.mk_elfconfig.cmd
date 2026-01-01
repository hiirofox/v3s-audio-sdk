cmd_scripts/mod/mk_elfconfig := /usr/bin/gcc -O2 -isystem /home/hiirofox/v3s-sdk/buildroot/output/host/include -L/home/hiirofox/v3s-sdk/buildroot/output/host/lib -Wl,-rpath,/home/hiirofox/v3s-sdk/buildroot/output/host/lib -Wp,-MMD,scripts/mod/.mk_elfconfig.d -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu11 -Wdeclaration-after-statement         -o scripts/mod/mk_elfconfig scripts/mod/mk_elfconfig.c   

source_scripts/mod/mk_elfconfig := scripts/mod/mk_elfconfig.c

deps_scripts/mod/mk_elfconfig := \

scripts/mod/mk_elfconfig: $(deps_scripts/mod/mk_elfconfig)

$(deps_scripts/mod/mk_elfconfig):
