#ifndef LSM303_H
#define LSM303_H

#include "stm32f4xx_hal.h"
#include <stdint.h>

/* Debido a lo que entiendo como que la placa stm32F411 no tiene un acelerometro que pueda "hablar" SPI sino solamente I2C
 * tenia dos opciones, utilizar el giroscopio en lugar del acelerometro o usar I2C y por simple recomendacion y supuesta
 * simplicidad voy a usar el acelerometro y usar I2C
 *
 */


// --- Constantes ---

// Dirección I2C del acelerómetro del LSM303 (0x19 desplazado 1 bit a la izq -> 0x32)
#define LSM303_ACCEL_ADDR        0x32

// Registros del acelerómetro
#define LSM303_CTRL_REG1_A       0x20
#define LSM303_OUT_X_L_A         0x28

// En los sensores de ST, para leer múltiples bytes seguidos con HAL_I2C_Mem_Read,
// se debe poner en 1 el bit más significativo (MSB) de la dirección del registro.
// 0x28 | 0x80 = 0xA8
#define LSM303_OUT_X_L_A_MULTI   0xA8

/**
 * @brief Estructura de la instancia del sensor LSM303
 */
typedef struct {
    I2C_HandleTypeDef *hi2c; // Puntero al handle del i2c


    volatile int16_t accel_x_raw;
    volatile int16_t accel_y_raw;
    volatile int16_t accel_z_raw;

} LSM303_HandleTypeDef;

/*
 * Esta funcion incializa el acelerometro para que pase de estar apagado a medir datos continuamente a 100 Hz.
 */
HAL_StatusTypeDef LSM303_Init(LSM303_HandleTypeDef *hlsm, I2C_HandleTypeDef *hi2c);
/*
 * Esta función solicita al acelerometro los datos mas recientes de aceleración
 * en las 3 dimensiones y los ensambla dentro de la estructura.
 */
HAL_StatusTypeDef LSM303_Read_Accel(LSM303_HandleTypeDef *hlsm);

#endif


