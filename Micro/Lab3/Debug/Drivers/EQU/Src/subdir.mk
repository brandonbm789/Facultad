################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (14.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/EQU/Src/HC_SR04.c \
../Drivers/EQU/Src/lm35.c 

OBJS += \
./Drivers/EQU/Src/HC_SR04.o \
./Drivers/EQU/Src/lm35.o 

C_DEPS += \
./Drivers/EQU/Src/HC_SR04.d \
./Drivers/EQU/Src/lm35.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/EQU/Src/%.o Drivers/EQU/Src/%.su Drivers/EQU/Src/%.cyclo: ../Drivers/EQU/Src/%.c Drivers/EQU/Src/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F411xE -c -I../Core/Inc -I../Drivers/STM32F4xx_HAL_Driver/Inc -I../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include -I../Drivers/CMSIS/Include -I"/home/brandonbm789/Facultad/Facultad/Micro/Lab3/Drivers/EQU" -I"/home/brandonbm789/Facultad/Facultad/Micro/Lab3/Drivers/EQU/Src" -I"/home/brandonbm789/Facultad/Facultad/Micro/Lab3/Drivers/EQU/Inc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Drivers-2f-EQU-2f-Src

clean-Drivers-2f-EQU-2f-Src:
	-$(RM) ./Drivers/EQU/Src/HC_SR04.cyclo ./Drivers/EQU/Src/HC_SR04.d ./Drivers/EQU/Src/HC_SR04.o ./Drivers/EQU/Src/HC_SR04.su ./Drivers/EQU/Src/lm35.cyclo ./Drivers/EQU/Src/lm35.d ./Drivers/EQU/Src/lm35.o ./Drivers/EQU/Src/lm35.su

.PHONY: clean-Drivers-2f-EQU-2f-Src

