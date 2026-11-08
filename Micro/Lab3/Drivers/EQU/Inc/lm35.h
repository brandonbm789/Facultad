#ifndef LM35_H
#define LM35_H

#include "stm32f4xx_hal.h"
#include <stdint.h>
#include <stdbool.h>

typedef struct {
	ADC_HandleTypeDef *hadc;
	uint32_t channel;


	volatile float data;
	volatile uint32_t _data_ready;
} LM35_HandleTypeDef;

void LM35_Init(LM35_HandleTypeDef *hlm35, ADC_HandleTypeDef *hadc, uint32_t canal);

float LM35_Read_Blocking(LM35_HandleTypeDef *hlm35);

void LM35_Start_Conversion(LM35_HandleTypeDef *hlm35);

bool LM35_Get_Temperature(LM35_HandleTypeDef *hlm35, float *out_temp);

#endif
