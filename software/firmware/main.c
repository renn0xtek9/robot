
#include "stm32f1xx_hal.h"

void _init(void)
{
}

int main(void)
{
    HAL_Init();

    __HAL_RCC_GPIOC_CLK_ENABLE();

    GPIO_InitTypeDef gpio = {0};
    gpio.Pin = GPIO_PIN_13;
    gpio.Mode = GPIO_MODE_OUTPUT_PP;
    gpio.Pull = GPIO_NOPULL;
    gpio.Speed = GPIO_SPEED_FREQ_LOW;

    HAL_GPIO_Init(GPIOC, &gpio);

    while (1)
    {
        HAL_GPIO_TogglePin(GPIOC, GPIO_PIN_13);
        HAL_Delay(2000);
    }
}

/* HAL time base interrupt */
void SysTick_Handler(void)
{
    HAL_IncTick();
}
