FROM ubuntu:xenial
# Setup
RUN dpkg --add-architecture i386 && \
  apt-get update && apt-get install -y \
            software-properties-common \
            wget \
            curl \
            adb \
            bzip2 \
            checkinstall \
            expect \
            git \
            lib32ncurses5 \
            libc6:i386 \
            libtool \
            libhidapi-dev \
            libhidapi-hidraw0 \
            libusb-0.1-4 \
            libusb-1.0-0 \
            libusb-1.0-0-dev \
            libusb-dev \
            make \
            python2.7 \
            ruby-full \
            automake \
            autotools-dev \
            pkg-config \
            sudo

# Install cmake
RUN wget -qO- "https://cmake.org/files/v3.16/cmake-3.16.3-Linux-x86_64.tar.gz" | tar --strip-components=1 -xz -C /usr/local && cmake --version

# Download and install arm-gcc and Download and install nrfjprog
RUN wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/7-2017q4/gcc-arm-none-eabi-7-2017-q4-major-linux.tar.bz2 && tar -xf gcc-arm-none-eabi-7-2017-q4-major-linux.tar.bz2 -C /usr/local && wget https://www.nordicsemi.com/-/media/Software-and-other-downloads/Desktop-software/nRF-command-line-tools/sw/Versions-10-x-x/nRFCommandLineTools1021Linuxamd64tar.gz && tar -xvzf nRFCommandLineTools1021Linuxamd64tar.gz && dpkg -R --install *.deb

# Download and install openocd
RUN mkdir -p /usr/src/; cd /usr/src/ \
    && git clone --depth 1 https://github.com/ntfreak/openocd.git \
    && cd openocd \
    && ./bootstrap \
    && ./configure --enable-stlink --enable-jlink --enable-ftdi --enable-cmsis-dap \
    && make -j"$(nproc)" \
    && make install-strip \
    && cp /usr/src/openocd/contrib/60-openocd.rules /etc/udev/rules.d/60-openocd.rules \
    && cd .. \
    && rm -rf openocd \
    && echo 'set auto-load safe-path /' >> ~/.gdbinit

# Clone CMSIS libraries and install pip
RUN cd /usr/src/ && git clone https://github.com/ARM-software/CMSIS.git && cd /usr/local/ && wget https://bootstrap.pypa.io/get-pip.py && python2.7 get-pip.py && pip install nrfutil


COPY do /root/
COPY build.sh /root/
COPY .gdbinit /root/ 
COPY rcfile.docker /root



ENV CMSIS_DSP_DIR=/usr/src/CMSIS/CMSIS/DSP_Lib/Source
ENV OPENOCD_DIR /usr/local/share/openocd
ENV OPENOCD_INTERFACE "$OPENOCD_DIR/scripts/interface/jlink.cfg"
ENV OPENOCD_TARGET "$OPENOCD_DIR/scripts/target/nrf52.cfg"
ENV ARM /usr/local/gcc-arm-none-eabi-7-2017-q4-major/bin
ENV NPROG /usr/local/nrfjprog/nrfjprog/
ENV MHEX /usr/local/nrfjprog/mergehex/

ENV PATH "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$ARM:$NPROG:$MHEX:$RTT:$PATH"

RUN echo "export PATH=${PATH}" >> /root/.bashrc

WORKDIR /root
