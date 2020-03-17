# nrf5x_cmake_docker

NOTE: not work correctly now (need to configure properly main.c and include config to create basic binary. It working well with sdk examples)

# info
Nordic nrf5x basic cmake project template with all needed dockerfile

This project is just answer for nice developing for Nordic nrf5x MCUs. Want to use nice cmake standard and everything-needed docker image that could be used for local developing and also nice CI (continuous integration) purposes. (ps. why Nordic dont have any good toolchain plug for cmake?:p)

This repo is using some both solutions from both github repositories:

cmake with nrf5x: https://github.com/Polidea/cmake-nRF5x.git
nrf5x docker image: https://github.com/labishrestha/NRF52-devenv-gcc.git

I just make is more clearly and combine them into (imho) nice to simply using 

ps. There are a lot work to do with it to make it more generic. You are welcome to participate;)


# how it work in short

Image created have all necessary with toolchain like compiler, nrfjprog, openocd, etc. But you need to bind (mount) nordic sdk and project itself.
you can create build directory everywhere in docker container. So if you create one in project root directory it will remain localy on host. But if you dont need it (because You just flash device) you can create it outside of mounted directory like in created /root/build

I testing it on my lab environment that have jlink drivers. If i am right, you need to install necessary drivers for your flash-er/debugger device


# how to use

* build docker image with: `sudo docker build . -t nrfdev_sdk` (will take some time...)
* download nordic sdk
* change in nordic sdk Makefile.posix (located somewhere in toolchain): `GNU_INSTALL_ROOT` variable to include:  gcc-arm-none-eabi-7-2017-q4
* run it by ./do.sh `<path-to-your-nordic-sdk>`

voila! ;)
