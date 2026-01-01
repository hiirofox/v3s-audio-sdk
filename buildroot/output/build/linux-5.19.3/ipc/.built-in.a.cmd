cmd_ipc/built-in.a := rm -f ipc/built-in.a; echo  | sed -E 's:([^ ]+):ipc/\1:g' | xargs /home/hiirofox/v3s-sdk/buildroot/output/host/bin/arm-buildroot-linux-gnueabihf-ar cDPrST ipc/built-in.a
