cmake_minimum_required(VERSION 4.4)
project(firmware C ASM)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../cmake")
set(CUBE_ROOT "/opt/st/STM32CubeF1/")

set(HAL "${CUBE_ROOT}/Drivers/STM32F1xx_HAL_Driver")
set(CMSIS "${CUBE_ROOT}/Drivers/CMSIS")
set(DEVICE "${CMSIS}/Device/ST/STM32F1xx")

add_executable(firmware.elf
    main.c
    "${DEVICE}/Source/Templates/system_stm32f1xx.c"
    "${DEVICE}/Source/Templates/gcc/startup_stm32f103xb.s"
    "${HAL}/Src/stm32f1xx_hal.c"
    "${HAL}/Src/stm32f1xx_hal_cortex.c"
    "${HAL}/Src/stm32f1xx_hal_gpio.c"
    "${HAL}/Src/stm32f1xx_hal_rcc.c"
    "${HAL}/Src/stm32f1xx_hal_rcc_ex.c"
)

target_include_directories(firmware.elf PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    "${HAL}/Inc"
    "${CMSIS}/Include"
    "${DEVICE}/Include"
)

target_compile_definitions(firmware.elf PRIVATE
    USE_HAL_DRIVER
    STM32F103xB
)

target_compile_options(firmware.elf PRIVATE
    -mcpu=cortex-m3
    -mthumb
    -ffunction-sections
    -fdata-sections
    -Wall
    -Wextra
)

target_link_options(firmware.elf PRIVATE
    -mcpu=cortex-m3
    -mthumb
    -nostartfiles
    --specs=nano.specs
    --specs=nosys.specs
    "-T${CMAKE_CURRENT_SOURCE_DIR}/linker/STM32F103C8TX_FLASH.ld"
    -Wl,--gc-sections
    "-Wl,-Map=${CMAKE_CURRENT_BINARY_DIR}/firmware.map"
)

set_target_properties(firmware.elf PROPERTIES
    SUFFIX ""
)

add_custom_command(TARGET firmware.elf POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O binary
        $<TARGET_FILE:firmware.elf>
        ${CMAKE_CURRENT_BINARY_DIR}/firmware.bin
    COMMENT "Generating firmware.bin"
)
