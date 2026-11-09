#include "lsm303.h"

HAL_StatusTypeDef LSM303_Init(LSM303_HandleTypeDef *hlsm, I2C_HandleTypeDef *hi2c) {
    hlsm->hi2c = hi2c;

    // Envia un "ping" I2C a la direccion del acelerometro para ver que esté presente y responda
    // da dos intentos con un tiempo de 100ms y si no responde frena y da error.
    if (HAL_I2C_IsDeviceReady(hlsm->hi2c, LSM303_ACCEL_ADDR, 2, 100) != HAL_OK) {
        return HAL_ERROR;
    }

    // Escribimos 0x57 en CTRL_REG1_A para encender el sensor:
    // 0x57 = 0101 0111 -> 100 Hz de velocidad (0101), modo normal, habilita ejes X, Y y Z (111) (muy flashero)
    // el 0 antes de los 111 indica el consumo en modo normal del acelerometro
    uint8_t ctrl_reg1 = 0x57;

    // Envía el byte 0x57 por el bus I2C al registro 0x20 (CTRL_REG1_A) del sensor.
    // Si el sensor acepta la orden, devuelve HAL_OK.
    return HAL_I2C_Mem_Write(hlsm->hi2c, LSM303_ACCEL_ADDR, LSM303_CTRL_REG1_A, 1, &ctrl_reg1, 1, 100);
}


HAL_StatusTypeDef LSM303_Read_Accel(LSM303_HandleTypeDef *hlsm) {
    uint8_t raw_buffer[6]; // cada eje guarda 2 bytes de datos crudos
    HAL_StatusTypeDef status;

    // Leemos 6 bytes usando la dirección con el bit de auto-incremento (0xA8)
    status = HAL_I2C_Mem_Read(hlsm->hi2c, LSM303_ACCEL_ADDR, LSM303_OUT_X_L_A_MULTI, 1, raw_buffer, 6, 100);

    if (status == HAL_OK) {
        // El LSM303 es "Little Endian": envía primero el byte BAJO y luego el ALTO.
        // A diferencia del MPU6050, el orden se invierte al armar el entero de 16 bits.
        hlsm->accel_x_raw = (int16_t)((raw_buffer[1] << 8) | raw_buffer[0]);
        hlsm->accel_y_raw = (int16_t)((raw_buffer[3] << 8) | raw_buffer[2]);
        hlsm->accel_z_raw = (int16_t)((raw_buffer[5] << 8) | raw_buffer[4]);

        // Nota: Dependiendo de la resolución configurada (normalmente 12 bits justificados a la izquierda),
        // los valores crudos pueden necesitar un desplazamiento extra (>> 4) para cálculos matemáticos precisos.
    }

    return status;
}
