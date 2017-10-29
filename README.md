Build
=====
Requires a Unix like environment with a POSIX shell and the usual suspects
(grep, sed, awk, which etc)

Dependencies
* GNU Make
* Binutils
* GCC

Building
--------

In top folder
```
export PATH="$PATH:$HOME/ikaros/bin"
./build --prefix=$HOME/ikaros --target=x86_64 \
	--enable-debug --sysroot=$HOME/ikaros-x86_64
```

| Option                    | Description                                    |
| ------------------------- | ---------------------------------------------- |
| --build-toolchain         | Build toolchain even if it already is present  |
| --prefix=*path*           | Prefix for toolchain                           |
| --target=*target*         | Target                                         |
| --bsp-target=*bsp-target* | BSP Target. Only valid on ARM and AARCH64      |
| --sysroot=*path*          | Target system root                             |
| --enable-debug            | Generate debug symbols                         |
| --disable-debug           | Do not generate debug symbols                  |
| --num-threads=*num*       | Number of threads to use for build             |

Valid targets
-------------
| Target                    | Description                                    |
| ------------------------- | ---------------------------------------------- |
| i[3-7]86                  | PC 32 Bit. Legacy                              |
| x86_64                    | PC 64 Bit                                      |
| arm                       | ARM 32 bit. Requires BSP target parameter      |
| aarch64                   | ARM 64 bit. Requires BSP target parameter      |

Valid ARM BSP targets
---------------------
| BSP                       | Description                                    |
| ------------------------- | ---------------------------------------------- |
| rpi2                      | Raspberry Pi 2                                 |
| beaglebone                | Beaglebone                                     |
| pandaboard                | Pandaboard                                     |

Valid AARCH64 BSP targets
-------------------------
| BSP                       | Description                                    |
| ------------------------- | ---------------------------------------------- |
| rpi2                      | Raspberry Pi 2                                 |
