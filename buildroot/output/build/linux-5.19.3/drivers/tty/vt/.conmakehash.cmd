cmd_drivers/tty/vt/conmakehash := /usr/bin/gcc -O2 -isystem /home/hiirofox/v3s-sdk/buildroot/output/host/include -L/home/hiirofox/v3s-sdk/buildroot/output/host/lib -Wl,-rpath,/home/hiirofox/v3s-sdk/buildroot/output/host/lib -Wp,-MMD,drivers/tty/vt/.conmakehash.d -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu11 -Wdeclaration-after-statement         -o drivers/tty/vt/conmakehash drivers/tty/vt/conmakehash.c   

source_drivers/tty/vt/conmakehash := drivers/tty/vt/conmakehash.c

deps_drivers/tty/vt/conmakehash := \

drivers/tty/vt/conmakehash: $(deps_drivers/tty/vt/conmakehash)

$(deps_drivers/tty/vt/conmakehash):
