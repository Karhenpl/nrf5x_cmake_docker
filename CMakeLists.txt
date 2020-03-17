cmake_minimum_required(VERSION 3.9)

set(NRF_TARGET "nrf52")

# optional, won't be used if passing toolchain on command line (see below)
if (NOT DEFINED ARM_NONE_EABI_TOOLCHAIN_PATH)
    set(ARM_NONE_EABI_TOOLCHAIN_PATH "/usr/local/bin")
endif ()

# need to define this in docker run
if(NOT DEFINED ENV{SDK_DIR})
    message(FATAL_ERROR "SDK_DIR environment is not configured!")
endif()

if(NOT DEFINED ENV{NRFJPROG_DIR})
    message(FATAL_ERROR "NRFJPROG_DIR environment is not configured!")
endif()

set(NRF5_SDK_PATH $ENV{SDK_DIR})
set(NRFJPROG $ENV{NRFJPROG_DIR})
message("NRF5_SDK_PATH is: ${NRF5_SDK_PATH}")
message("NRFJPROG is in: ${NRFJPROG}")


set(ARM_NONE_EABI_TOOLCHAIN_PATH "/usr/local/gcc-arm-none-eabi-7-2017-q4-major")
set(NRF52X_DEVICE_NAME nrf52832)

include("tools/cmake/CMake_nRF5x.cmake")

# must be called before first project call or add_subdirectory unless passing on command line
nRF5x_toolchainSetup()

project(nrf52_sys0 C ASM)

nRF5x_setup()

nRF5x_addAppScheduler()
nRF5x_addAppFIFO()
nRF5x_addAppTimer()
nRF5x_addAppUART()
nRF5x_addAppButton()
nRF5x_addBSP(TRUE FALSE FALSE)
nRF5x_addBLEGATT()


nRF5x_addBLEService(ble_bas)

# add_definitions(-DCONFIG_GPIO_AS_PINRESET)
        
include_directories("./include")
list(APPEND SOURCE_FILES "./src/main.c")

nRF5x_addExecutable(${PROJECT_NAME} "${SOURCE_FILES}")