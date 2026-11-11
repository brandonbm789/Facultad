/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.c
  * @brief          : Main program body
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2026 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
/* USER CODE END Header */
/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "adc.h"
#include "i2c.h"
#include "tim.h"
#include "gpio.h"
#include "lsm303.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */
#include "HC_SR04.h"
#include "lm35.h"

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */
static LSM303_HandleTypeDef acelerometro;
static HCSR04_HandleTypeDef sensor;
static LM35_HandleTypeDef sens_temp_NB;
static LM35_HandleTypeDef sens_temp1;
static LM35_HandleTypeDef sens_temp2;
/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/

/* USER CODE BEGIN PV */
volatile float accel_x_g = 0.0f;
volatile float accel_y_g = 0.0f;
volatile float accel_z_g = 0.0f;
/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
/* USER CODE BEGIN PFP */
void HAL_TIM_IC_CaptureCallback(TIM_HandleTypeDef *htim);
/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */


/* USER CODE END 0 */

/**
  * @brief  The application entry point.
  * @retval int
  */
int main(void)
{

  /* USER CODE BEGIN 1 */
	uint32_t currentTime = 0;
	uint32_t previousTime = 0;
	uint32_t previousTime_LED = 0;
	float distance = 0;
	float temp_sens_1 = 0.0f;
	float temp_sens_2 = 0.0f;
	float temp_NB = 0.0f;

	sensor.htim = &htim2;
	sensor.IC_Channel = TIM_CHANNEL_1;
	sensor.Trig_Port = TRIGGER_GPIO_Port;
	sensor.Trig_Pin = TRIGGER_Pin;

	uint32_t last_time_hcsr04 = 0;
	uint32_t last_time_lm35 = 0;
	uint32_t last_time_alarm = 0;
	uint8_t alarm_active = 0;

  /* USER CODE END 1 */

  /* MCU Configuration--------------------------------------------------------*/

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

  /* USER CODE BEGIN Init */

  LM35_Init(&sens_temp_NB, &hadc1, ADC_CHANNEL_1); //prueba no bloqueante
//  LM35_Init(&sens_temp1, &hadc1, ADC_CHANNEL_1);
//  LM35_Init(&sens_temp2, &hadc1, ADC_CHANNEL_1);

  /* USER CODE END Init */

  /* Configure the system clock */
  SystemClock_Config();

  /* USER CODE BEGIN SysInit */

  /* USER CODE END SysInit */

  /* Initialize all configured peripherals */
  MX_GPIO_Init();
  MX_TIM2_Init();
  MX_ADC1_Init();
  MX_I2C1_Init();
  /* USER CODE BEGIN 2 */
  	LM35_Start_Conversion(&sens_temp_NB); //prueba no bloqueante

	hcsr04_init(&sensor);
	hcsr04_start_measurement(&sensor);


	if (LSM303_Init(&acelerometro, &hi2c1) != HAL_OK) {
	      Error_Handler();
	  }
  /* USER CODE END 2 */

  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
  while (1)
  {
    /* USER CODE END WHILE */

    /* USER CODE BEGIN 3 */
	  currentTime = HAL_GetTick();
//	  if (hcsr04_is_data_ready(&sensor)) {
//		  distance = hcsr04_get_distance_cm(&sensor);
//		  if (distance > 50.0) {
//				HAL_GPIO_WritePin(LD3_GPIO_Port, LD3_Pin, GPIO_PIN_RESET);
//				HAL_GPIO_WritePin(LD4_GPIO_Port, LD4_Pin, GPIO_PIN_SET);
//				HAL_GPIO_WritePin(LD5_GPIO_Port, LD5_Pin, GPIO_PIN_RESET);
//		  } else if (20.0 <= distance && distance <= 50.0){
//			  	HAL_GPIO_WritePin(LD3_GPIO_Port, LD3_Pin, GPIO_PIN_SET);
//			    HAL_GPIO_WritePin(LD4_GPIO_Port, LD4_Pin, GPIO_PIN_RESET);
//			    HAL_GPIO_WritePin(LD5_GPIO_Port, LD5_Pin, GPIO_PIN_RESET);
//		  } else {
//			    HAL_GPIO_WritePin(LD3_GPIO_Port, LD3_Pin, GPIO_PIN_RESET);
//			    HAL_GPIO_WritePin(LD4_GPIO_Port, LD4_Pin, GPIO_PIN_RESET);
//			    HAL_GPIO_WritePin(LD5_GPIO_Port, LD5_Pin, GPIO_PIN_SET);
//		  }
//	}
//
//	  if (currentTime - previousTime >= 60) {
//		hcsr04_start_measurement(&sensor);
//		previousTime = currentTime;
//	}

	  // ----------------------------- Desafio 2 ------------------------------------------------------------

//	  temp_sens_1 = LM35_Read_Blocking(&sens_temp1);
//	  temp_sens_2 = LM35_Read_Blocking(&sens_temp2);
//
//	  if (LM35_Get_Temperature(&sens_temp_NB, &temp_NB) == true) {
//		 LM35_Start_Conversion(&sens_temp_NB);
//	}
//

	  // ------------------------------ Desafio 3 ---------------------------------------------------------

//	  LSM303_Read_Accel(&acelerometro);
//
//	  // 2. Conversión a Fuerzas G reales
//	  accel_x_g = (float)(acelerometro.accel_x_raw >> 4) * 0.001f;
//	  accel_y_g = (float)(acelerometro.accel_y_raw >> 4) * 0.001f;
//	  accel_z_g = (float)(acelerometro.accel_z_raw >> 4) * 0.001f;
//
//	  // 3. Control de LEDs por Inclinación (Umbral de ±0.4g)
//	  // Eje X: Inclinación Lateral (Izquierda / Derecha)
//	  if (accel_x_g > 0.4f) {
//		  HAL_GPIO_WritePin(GPIOD, LD4_Pin, GPIO_PIN_SET);   // Enciende LED Verde
//		  HAL_GPIO_WritePin(GPIOD, LD5_Pin, GPIO_PIN_RESET);
//	  } else if (accel_x_g < -0.4f) {
//		  HAL_GPIO_WritePin(GPIOD, LD4_Pin, GPIO_PIN_RESET);
//		  HAL_GPIO_WritePin(GPIOD, LD5_Pin, GPIO_PIN_SET);   // Enciende LED Rojo
//	  } else {
//		  HAL_GPIO_WritePin(GPIOD, LD4_Pin | LD5_Pin, GPIO_PIN_RESET);
//	  }
//
//	  // Eje Y: Inclinación Frontal (Adelante / Atrás)
//	  if (accel_y_g > 0.4f) {
//		  HAL_GPIO_WritePin(GPIOD, LD3_Pin, GPIO_PIN_SET);   // Enciende LED Naranja
//		  HAL_GPIO_WritePin(GPIOD, LD6_Pin, GPIO_PIN_RESET);
//	  } else if (accel_y_g < -0.4f) {
//		  HAL_GPIO_WritePin(GPIOD, LD3_Pin, GPIO_PIN_RESET);
//		  HAL_GPIO_WritePin(GPIOD, LD6_Pin, GPIO_PIN_SET);   // Enciende LED Azul
//	  } else {
//		  HAL_GPIO_WritePin(GPIOD, LD3_Pin | LD6_Pin, GPIO_PIN_RESET);
//	  }


	  // problema de parpadeo de led azul

//	  HAL_GPIO_TogglePin(GPIOD, LD6_Pin);
//	  HAL_Delay(500);

	  // parpadeo no bloqueante


//	 if (currentTime - previousTime_LED >= 500) {
//		 HAL_GPIO_TogglePin(GPIOD, LD6_Pin);
//		 previousTime_LED = currentTime;
//	}

	  //------------------------ desafio 4 ----------------------------------


	  	  LSM303_Read_Accel(&acelerometro);

	  	  // 2. Conversión a Fuerzas G reales
	  	  accel_x_g = (float)(acelerometro.accel_x_raw >> 4) * 0.001f;
	  	  accel_y_g = (float)(acelerometro.accel_y_raw >> 4) * 0.001f;
	  	  accel_z_g = (float)(acelerometro.accel_z_raw >> 4) * 0.001f;

	  	  // 3. Control de LEDs por Inclinación (Umbral de ±0.4g)
	  	  // Eje X: Inclinación Lateral (Izquierda / Derecha)
	  	  if (accel_x_g > 0.4f) {
	  		  HAL_GPIO_WritePin(GPIOD, LD4_Pin, GPIO_PIN_SET);   // Enciende LED Verde
	  	  } else {
	  		  HAL_GPIO_WritePin(GPIOD, LD4_Pin, GPIO_PIN_RESET);
	  	  }

	  	  if (alarm_active == 0){

			  if (accel_x_g < -0.4f) {
				  HAL_GPIO_WritePin(GPIOD, LD5_Pin, GPIO_PIN_SET);
			  } else {
				  HAL_GPIO_WritePin(GPIOD, LD5_Pin, GPIO_PIN_RESET);
			  }
	  	  }

	  	  // Eje Y: Inclinación Frontal (Adelante / Atrás)
	  	  if (accel_y_g > 0.4f) {
	  		  HAL_GPIO_WritePin(GPIOD, LD3_Pin, GPIO_PIN_SET);   // Enciende LED Naranja
	  		  HAL_GPIO_WritePin(GPIOD, LD6_Pin, GPIO_PIN_RESET);
	  	  } else if (accel_y_g < -0.4f) {
	  		  HAL_GPIO_WritePin(GPIOD, LD3_Pin, GPIO_PIN_RESET);
	  		  HAL_GPIO_WritePin(GPIOD, LD6_Pin, GPIO_PIN_SET);   // Enciende LED Azul
	  	  } else {
	  		  HAL_GPIO_WritePin(GPIOD, LD3_Pin | LD6_Pin, GPIO_PIN_RESET);
	  	  }

	  	  if (hcsr04_is_data_ready(&sensor)) {
	  		  distance = hcsr04_get_distance_cm(&sensor);

	  		  if(distance < 15.0f){
	  			  alarm_active = 1;
	  		  } else {
	  			  alarm_active = 0;
	  		  }
	  	  }

	  	  if (currentTime - last_time_hcsr04 >= 100){
	  		  hcsr04_start_measurement(&sensor);
	  		  last_time_hcsr04 = currentTime;
	  	  }

	  	  if (currentTime - last_time_lm35 >= 100){
	  		  if (LM35_Get_Temperature(&sens_temp_NB, &temp_NB)){
	  			  LM35_Start_Conversion(&sens_temp_NB);
	  		  }
	  		  last_time_lm35 = currentTime;
	  	  }

	  	  if (alarm_active == 1){
	  		  if (currentTime - last_time_alarm >= 100){
	  			  HAL_GPIO_TogglePin(GPIOD, LD5_Pin);
	  			  last_time_alarm = currentTime;
	  		  }
	  	  }



  }
  /* USER CODE END 3 */
}

/**
  * @brief System Clock Configuration
  * @retval None
  */
void SystemClock_Config(void)
{
  RCC_OscInitTypeDef RCC_OscInitStruct = {0};
  RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};

  /** Configure the main internal regulator output voltage
  */
  __HAL_RCC_PWR_CLK_ENABLE();
  __HAL_PWR_VOLTAGESCALING_CONFIG(PWR_REGULATOR_VOLTAGE_SCALE1);

  /** Initializes the RCC Oscillators according to the specified parameters
  * in the RCC_OscInitTypeDef structure.
  */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSI;
  RCC_OscInitStruct.HSIState = RCC_HSI_ON;
  RCC_OscInitStruct.HSICalibrationValue = RCC_HSICALIBRATION_DEFAULT;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_NONE;
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  {
    Error_Handler();
  }

  /** Initializes the CPU, AHB and APB buses clocks
  */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                              |RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_HSI;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV4;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV2;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_0) != HAL_OK)
  {
    Error_Handler();
  }
}

/* USER CODE BEGIN 4 */
void HAL_TIM_IC_CaptureCallback(TIM_HandleTypeDef *htim){
	hcsr04_tim_ic_callback(&sensor, htim);
}

void HAL_ADC_ConvCpltCallback(ADC_HandleTypeDef* hadc) {

	if(hadc == sens_temp_NB.hadc){
		sens_temp_NB.data = HAL_ADC_GetValue(hadc);

		sens_temp_NB._data_ready = 1;

		HAL_ADC_Stop_IT(hadc);
	}

}

/* USER CODE END 4 */

/**
  * @brief  This function is executed in case of error occurrence.
  * @retval None
  */
void Error_Handler(void)
{
  /* USER CODE BEGIN Error_Handler_Debug */
  /* User can add his own implementation to report the HAL error return state */
  __disable_irq();
  while (1)
  {
  }
  /* USER CODE END Error_Handler_Debug */
}
#ifdef USE_FULL_ASSERT
/**
  * @brief  Reports the name of the source file and the source line number
  *         where the assert_param error has occurred.
  * @param  file: pointer to the source file name
  * @param  line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t *file, uint32_t line)
{
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */
}
#endif /* USE_FULL_ASSERT */
