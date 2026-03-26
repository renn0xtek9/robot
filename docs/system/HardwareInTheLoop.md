# Hardware in the loop 

# Hardware in the loop for raspberry Pi controller 

## Wiring
The setup uses STLinkV2 connector, connected over USB. 
There is a UART communication between the Raspberry Pi4B and the STM32.
```mermaid
flowchart LR
    subgraph RPI["Raspberry Pi 4B"]
        USB["USB"]
        UART_TX["GPIO 14"]
        UART_RX["GPIO 15"]
        RPI_3V3["3.3V"]
        RPI_GND["GND"]
        RPI_RESET_TRIGGER["GPIO24"]
    end

    subgraph STM32["STM32 Blue pill"]
        ST_GND["GND"]
        ST_USART_RX["USART RX (PA10)"]
        ST_USART_TX["USART TX (PA9)"]
        ST_PA13["SWDIO (PA13)"]
        ST_PA14["SWCLK (PA14)"]
        ST_3V3["3.3V"]
        ST_NRST["NRST"]
        ST_BOOT0["BOOT0"]
        
    end

    subgraph STLINK["STLink V2"]
        STL_USB["USB"]
        STL_SWDIO["SWDIO"]
        STL_SWCLK["SWCLK"]
        STL_GND["GND"]
        STL_3V3["3.3V"]
    end

    UART_TX --> ST_USART_RX
    UART_RX --- ST_USART_TX
    USB --- STL_USB

    STL_SWDIO --- ST_PA13
    STL_SWCLK --- ST_PA14
    STL_GND --- ST_GND
    RPI_3V3 --- ST_3V3

    RPI_GND --- ST_GND
    RPI_RESET_TRIGGER --- 1kohm ---  ST_NRST 
```
**STM32 bluepill pining**  
![image](./STM32-Bluepill-pining.jpg)

**Raspberry Pi4B pining**  
See this page for the [Rasperry Pi pining](https://www.raspberrypi.com/documentation/computers/raspberry-pi.html).
Look especially at this [diagram](https://www.raspberrypi.com/documentation/computers/images/GPIO-Pinout-Diagram-2.png?hash=df7d7847c57a1ca6d5b2617695de6d46)


## Workflow 

The firmware is flashed from the raspberry pi to the STM32 with 
```
st-flash write firmware.bin 0x08000000
``` 

The chip is then reset like this 
```
st-flash reset
```

During exection whe can also Pull the NRST directly from RPI GPIO to stop execution.
