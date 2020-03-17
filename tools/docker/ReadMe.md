before run: change in SDK Makefile.posix:
`GNU_INSTALL_ROOT` variable to include:  gcc-arm-none-eabi-7-2017-q4

run: 

    sudo PROJECT_DIR=<path-to-project> SDK_DIR=<path-to-SDK> ./do bash

docker-compose.yml could be developed future

# below is just some copy from 3rd-party repository

From subrepo Readme
## Using build system

1. Edit **rcfile.docker** and modify the **PRJROOT** variable to point to the desired project folder
2. Enter the following command to build the project and flash to target
```
./do flash
```
Alternately, its also possible to run an interactive shell on the docker container and build directly on the container. To login to the docker container, enter:
```
./do bash
```

Project can be built on the docker container using the ***build.sh*** script directly. To build on docker, enter the container in interactive shell, then run enter the following command:

```
./build.sh flash
```

## Debugging the target
To debug the target using gdb, enter the following command
```
./do debug-notui
```
Note that TUI mode will only work when gdb is run in container shell (./do bash)

To run gdb with TUI, login to the container shell and run
```
./build.sh debug
```

Alternately you can also run openocd gdb server and connect to target from Netbeans, eclipse, etc.
To start openocd gdb server, run the following command:
```
./do openocd
```

## Building and flashing DFU bootloader project
Bootloader project path is defined in **rcfile.docker** as ***BTLDR***
After setting the path to the correct folder, the bootloader can be built as follows:
```
./do boot
```