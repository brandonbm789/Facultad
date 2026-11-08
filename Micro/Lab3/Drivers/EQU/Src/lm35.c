#include "lm35.h"

void LM35_Init(LM35_HandleTypeDef *hlm35, ADC_HandleTypeDef *hadc, uint32_t canal){
	hlm35->_data_ready = 0;
	hlm35->data = 0;
	hlm35->hadc = hadc;
	hlm35->channel = canal;
}

float LM35_Read_Blocking(LM35_HandleTypeDef *hlm35){

	float temperature;

	ADC_ChannelConfTypeDef sConfig = {0};
	sConfig.Channel = hlm35->channel;
	sConfig.Rank = 1;
	sConfig.SamplingTime = ADC_SAMPLETIME_84CYCLES;

	HAL_ADC_ConfigChannel(hlm35->hadc, &sConfig);

	HAL_ADC_Start(hlm35->hadc);

	if(HAL_ADC_PollForConversion(hlm35->hadc, 10) == HAL_OK){
		uint32_t raw = HAL_ADC_GetValue(hlm35->hadc);
		float voltaje = (float)raw * 3.3f / 4095.0f;
		temperature = voltaje * 100.0f;
	}

	HAL_ADC_Stop(hlm35->hadc);
	return temperature;
}

void LM35_Start_Conversion(LM35_HandleTypeDef *hlm35){

	ADC_ChannelConfTypeDef sConfig = {0};
	sConfig.Channel = hlm35->channel;
	sConfig.Rank = 1;
	sConfig.SamplingTime = ADC_SAMPLETIME_84CYCLES;

	HAL_ADC_ConfigChannel(hlm35->hadc, &sConfig);

	HAL_ADC_Start_IT(hlm35->hadc);
}

bool LM35_Get_Temperature(LM35_HandleTypeDef *hlm35, float *out_temp){

	if (hlm35->_data_ready == 1) {
		float temp = (float)hlm35->data * 330.0f / 4095.0f;
		*out_temp = temp;

		hlm35->_data_ready = 0;

		return true;
	}

	return false;
}


