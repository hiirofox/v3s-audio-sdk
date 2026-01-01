cmd_certs/built-in.a := rm -f certs/built-in.a; echo  | sed -E 's:([^ ]+):certs/\1:g' | xargs /home/hiirofox/v3s-sdk/buildroot/output/host/bin/arm-buildroot-linux-gnueabihf-ar cDPrST certs/built-in.a
