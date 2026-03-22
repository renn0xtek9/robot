# Hardware in the loop 

# Hardware in the loop for raspberry Pi controller 


The setup uses STLinkV2 connector, connected over USB. 
There is a UART communication between the Raspberry Pi4B and the STM32.
```mermaid
flowchart LR
    subgraph RPI["Raspberry Pi 4B"]
        USB["USB"]
        UART_TX["UART TX"]
        UART_RX["UART RX"]
    end

    subgraph STM32["STM32 Blue pill"]
        ST_GND["GND"]
        ST_USART_RX["USART RX (PA10)"]
        ST_USART_TX["USART TX (PA9)"]
        ST_PA13["SWDIO (PA13)"]
        ST_PA14["SWCLK (PA14)"]
        ST_3V3["3.3V"]
        
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
    STL_3V3 --- ST_3V3
```
