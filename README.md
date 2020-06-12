# prebuilt-multiarch-bin

prebuilt binaries for multiple architeture

all binaries are statically linked and stripped

## Items

- gdb
- socat
- busybox
- bind/reverse shell
- tcpdump
- strace
- dropbear(some arch)
- lsof

## Bind/Reverse Shell binary

run the bind shell without arguments like `./bind_shell` will listening on the port 3343 and `./bind_shell 6666` will listen on 6666.
run the reverse shell binary will connect to 127.0.0.1:3343 , use a hex editor the change cstring cotains the ip/port.

## gdb (*Important*)

- gdbserver is compiled without libthread_db
- gdb need libthread_db.so.1 to support multithread debug, if you run into SIGSEGV when `r` the program, run `set libthread-db-search-path 0` in gdb first, then there will be warning about libthread_db.so.1, just ignore it.

## Github Actions

the config file for buildroot and github actions' workflow file are in the `src` branch
